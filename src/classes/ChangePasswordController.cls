/**
 * An apex page controller that exposes the change password functionality
 */
public with sharing class ChangePasswordController {
    public String oldPassword {get; set;}
    public String newPassword {get; set;}
    public String verifyNewPassword {get; set;}        
    
    public PageReference changePassword() {
        return Site.changePassword(newPassword, verifyNewPassword, oldpassword);    
    }     
    
    public ChangePasswordController() {}
    
    @IsTest(SeeAllData=true) public static void testChangePasswordController() {
        // Instantiate a new controller with all parameters in the page
        ChangePasswordController controller = new ChangePasswordController();
        controller.oldPassword = '123456';
        controller.newPassword = 'qwerty1'; 
        controller.verifyNewPassword = 'qwerty1';                
        
        System.assertEquals(controller.changePassword(),null);
        //test comment
        //hotfix!
        //uncommitted change!
    }
    
    @RemoteAction
    public static void displayUserName()
    {
        List<User> users = [Select id from User];
    }
    
    public static PageReference goHome()
    {
        return null;
    }
    
    public static List<Account> getAllQuestions()
    {
    	return [select id, billingstreet from account where Id = :UserInfo.getUserId() ];
    } 
}