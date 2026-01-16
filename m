Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20AE8C982FE
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 20:18:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BE3D642ED3;
	Fri, 16 Jan 2026 21:18:02 +0100 (CET)
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com
 [209.85.218.65]) by mails.dpdk.org (Postfix) with ESMTP id 065A842EC5
 for <dev@dpdk.org>; Fri, 16 Jan 2026 21:18:01 +0100 (CET)
Received: by mail-ej1-f65.google.com with SMTP id
 a640c23a62f3a-b8707005183so402931466b.0
 for <dev@dpdk.org>; Fri, 16 Jan 2026 12:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768594680;
 x=1769199480; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7hz7qEy1i817Tdg+7LCR02/1TsN5/g0+f0i0HPsD+R0=;
 b=qhEge29tVdCNmBpi740md5lvEEyZkyjmdLXRX5IJIty8zEDXVcAo0fCVSi8BtKeVge
 Gn4F1l+/a7K4IAer2i9N0+TNiSHge48NlSeBUxwGXDWoKwHC0j6Vx3D7IWCwiy9smJ29
 LQgjorgdUKVlSn027NDBTvO93L9817igAvakN/a/g9aLfEzI794NwdpyutcL+0lksayD
 a2H35zD8k/2PXJbEfpChE3Sw9g9kp4VaxhX/fWt6+slRtXkcJZ44FOK0cTWRODKo7qiF
 Yq5oaq2oQr2IQWOYOud9feIruaII7CZTx5CooP+B0MTlZtm4Gybbujwj6fzKzalgPp14
 hcyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768594680; x=1769199480;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7hz7qEy1i817Tdg+7LCR02/1TsN5/g0+f0i0HPsD+R0=;
 b=pGU1McVKUuPL47xOyC1HkCrVrxO0HI2w9sJYpgixw1MMKzmHVEqDKasesJ8mGxum5/
 0A3w7DOwZ3ddMgXAY9/QyXm1FRCzJHyU92Ksa1Do9kcR0MuDlCiQ6CAKylIjTCkmTrus
 54CjV3L2sY0jj48Oj/6pZJtCjqeMdcODVEvDdhC0PjmuAN/FrV+zjaJK6RY40gAG8VeP
 8/8c8a93FWSYRmbTHxc3UgRZfquZjE5UJofS4VIXTN5gisoCmsKDYtROtwnYJFZZFw1O
 Rc97f43BZBoknNq6WA6zUprn+kAlhBoczWdOzb5yqXnUoxOK6tX5hcbYVq1XW9A/QK5L
 BOwQ==
X-Gm-Message-State: AOJu0Yx2RnieIiYfmC69/FPRm09DDZ4+KLUNxMWlSLmmmr9dqDw9yg6W
 gJ4wdJpHL6y3qAMXvbj0L7H4tlh4vVatjOT4Zs62QKNuYzDbhWUqwsSjtuPSd1zJfFYIXlr4rl6
 MPbnFIH4=
X-Gm-Gg: AY/fxX6coixcTUSGZXn3fPrPhL4bE9WGOU8KUwrjJcrUjvfXxf23f8aYrODNKJpLzIO
 WZxHOkX/oDKgMKaMCrfmE9TyChG7HcRjg1GO7hlGC2KdyFL6XysVtxqlhKGCR1K1oWAmwG6GXXo
 5DTmQkVOruvViKcov5OfYvMIYGEioWepI3xufBcvwwlZ0f9d0OTIP6yiC+ws7yKo7aHzl65Ecn8
 gLs/eaBbLXQpaqxqOnsW0U3vUM4B6Aupt5Nn3aJsWcujZIJHLlpsUYOS4NyWhCeaCgvtbzdUsIp
 80X/bQ/81j0VUP7z40yk80ACvpFkX+M2j955dutFIU+G3OfrWIqeofRygxH9QdeX+wTg1cgUkr+
 2acjrz+iUkW6R1229aBpWVrP0sRbbcfFcULcHTiBZIfkcrIgP91PHjw1oD9b59X1hzEvBau5Eyd
 IaGS1qfsDR+b3pwmsgAqYxccVhfBekG6SZfAxOjGlBH0Drh2IvZQ==
X-Received: by 2002:a17:906:2099:b0:b87:b0ba:5d2d with SMTP id
 a640c23a62f3a-b87b0ba6e99mr12876866b.57.1768594680399; 
 Fri, 16 Jan 2026 12:18:00 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8795169f10sm338631466b.26.2026.01.16.12.17.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 12:17:59 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 10/12] doc: improve vulnerability process documentation
Date: Fri, 16 Jan 2026 12:14:28 -0800
Message-ID: <20260116201738.74578-11-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260116201738.74578-1-stephen@networkplumber.org>
References: <20260114225555.127448-1-stephen@networkplumber.org>
 <20260116201738.74578-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

Improve the vulnerability management documentation
- Converting passive voice to active voice
- Using clearer section headings
- Simplifying verbose explanations
- Making reporting instructions more direct
- Fixing broken RST link syntax for mailing lists

No technical content changes.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/contributing/vulnerability.rst | 140 ++++++++++------------
 1 file changed, 65 insertions(+), 75 deletions(-)

diff --git a/doc/guides/contributing/vulnerability.rst b/doc/guides/contributing/vulnerability.rst
index fc60e02e37..1d616d203a 100644
--- a/doc/guides/contributing/vulnerability.rst
+++ b/doc/guides/contributing/vulnerability.rst
@@ -7,10 +7,9 @@ DPDK Vulnerability Management Process
 Scope
 -----
 
-Only the main repositories (dpdk and dpdk-stable) of the core project
-are in the scope of this security process (including experimental APIs).
-If a stable branch is declared unmaintained (end of life),
-no fix will be applied.
+This security process covers only the main repositories (dpdk and dpdk-stable)
+of the core project (including experimental APIs).
+The team will not apply fixes to stable branches declared unmaintained (end of life).
 
 All vulnerabilities are bugs, but not every bug is a vulnerability.
 Vulnerabilities compromise one or more of:
@@ -19,79 +18,71 @@ Vulnerabilities compromise one or more of:
 * Integrity (trustworthiness and correctness).
 * Availability (uptime and service).
 
-If in doubt, please consider the vulnerability as security sensitive.
+If in doubt, consider the vulnerability as security sensitive.
 At worst, the response will be to report the bug through the usual channels.
 
 
-Finding
--------
+Finding Security Issues
+-----------------------
 
 There is no pro-active security engineering effort at the moment.
 
-Please report any security issue you find in DPDK as described below.
+Report any security issue you find in DPDK as described below.
 
 
-Report
-------
+Reporting Security Issues
+-------------------------
 
-Do not use Bugzilla (unsecured).
-Instead, send GPG-encrypted emails
-to `security@dpdk.org <https://core.dpdk.org/security#contact>`_.
-Anyone can post to this list.
-In order to reduce the disclosure of a vulnerability in the early stages,
-membership of this list is intentionally limited to a `small number of people
-<https://mails.dpdk.org/roster/security>`_.
+Do not use Bugzilla to report security vulnerabilities, as it is not secured for such communication.
+Instead, send a GPG-encrypted email to `security@dpdk.org <https://core.dpdk.org/security#contact>`_.
+This address is open to all, but access to its inbox is intentionally limited to a small group
+to minimize the risk of early disclosure.
 
-It is additionally encouraged to GPG-sign one-on-one conversations
-as part of the security process.
+GPG-sign any one-on-one correspondence related to the vulnerability
+report as part of maintaining a secure communication process.
 
-As it is with any bug, the more information provided,
-the easier it will be to diagnose and fix.
-If you already have a fix, please include it with your report,
-as that can speed up the process considerably.
+As with any bug report, detailed information greatly aids in diagnosing and resolving the issue.
+If you have already developed a fix, include it in your submission to help accelerate resolution.
 
-In the report, please note how you would like to be credited
-for discovering the issue
-and the details of any embargo you would like to impose.
+In your report, specify how you would like to be credited for the discovery and mention any embargo
+period you wish to impose.
 
-If the vulnerability is not public yet,
-no patch or information should be disclosed publicly.
-If a fix is already published,
-the reporting process must be followed anyway, as described below.
+If the vulnerability has not yet been made public, do not disclose patches or related information
+publicly. Even if a fix has already been published, you must still follow the proper reporting process outlined here.
 
 
 Confirmation
 ------------
 
-Upon reception of the report, a security team member should reply
-to the reporter acknowledging that the report has been received.
+Upon receiving the report, a security team member should reply
+to the reporter acknowledging receipt.
 
 The DPDK security team reviews the security vulnerability reported.
-Area experts not members of the security team may be involved in the process.
-In case the reported issue is not qualified as a security vulnerability,
+Area experts who are not members of the security team may be involved in the process.
+If the reported issue does not qualify as a security vulnerability,
 the security team will request the submitter to report it
 using the usual channel (Bugzilla).
-If qualified, the security team will assess which DPDK version are affected.
-A bugzilla ID (allocated in a `reserved pool
+If qualified, the security team assesses which DPDK versions are affected.
+A bugzilla ID (allocated from a `reserved pool
 <https://bugs.dpdk.org/buglist.cgi?f1=bug_group&o1=equals&v1=security>`_)
 is assigned to the vulnerability, and kept empty until public disclosure.
 
-The security team calculates the severity score with
+The security team calculates the severity score with the
 `CVSS calculator <https://www.first.org/cvss/calculator/3.0>`_
 based on inputs from the reporter and its own assessment of the vulnerability,
 and agrees on the score with the reporter.
 
 An embargo may be put in place depending on the severity of the vulnerability.
-If an embargo is decided, its duration should be suggested by the security team
-and negotiated with the reporter.
+If an embargo is decided, the security team should suggest the duration
+and negotiate with the reporter.
 Embargo duration between vulnerability confirmation and public disclosure
 should be between **one and ten weeks**.
 If an embargo is not required, the vulnerability may be fixed
 using the standard patch process, once a CVE number has been assigned.
 
-The confirmation mail should be sent within **3 business days**.
+Send the confirmation mail within **3 business days**.
 
-Following information must be included in the mail:
+Include the following information in the mail:
 
 * Confirmation
 * CVSS severity and score
@@ -110,7 +101,7 @@ from the reporter before finalizing the document.
 When the document is final, the security team needs to
 request a CVE identifier from a CNA.
 
-The CVE request should be sent
+Send the CVE request
 to `secalert@redhat.com <mailto:secalert@redhat.com>`_
 using GPG encrypted email
 (see `contact details <https://access.redhat.com/security/team/contact>`_).
@@ -161,19 +152,18 @@ CVE Request Template without Embargo
 Fix Development and Review
 --------------------------
 
-If the fix is already published, this step is skipped,
-and the pre-release disclosure is replaced with the private disclosure,
-as described below. It must not be considered as the standard process.
+If the fix is already published, skip this step,
+and replace the pre-release disclosure with the private disclosure,
+as described below. This should not be considered the standard process.
 
-This step may be started in parallel with CVE creation.
-The patches fixing the vulnerability are developed and reviewed
-by the security team and
-by elected area experts that agree to maintain confidentiality.
+This step may start in parallel with CVE creation.
+The security team and elected area experts who agree to maintain confidentiality
+develop and review patches fixing the vulnerability.
 
-The CVE id and the bug id must be referenced in the patch if there is no
-embargo, or if there is an embargo, but it will be lifted when the release
-including the patch is published. If the embargo is going to be lifted after the
-release, then the CVE and bug ids must be omitted from the commit message.
+Reference the CVE id and the bug id in the patch if there is no
+embargo, or if the embargo will be lifted when the release
+including the patch is published. If the embargo will be lifted after the
+release, omit the CVE and bug ids from the commit message.
 
 Backports to the identified affected versions are done once the fix is ready.
 
@@ -181,32 +171,32 @@ Backports to the identified affected versions are done once the fix is ready.
 Pre-Release Disclosure
 ----------------------
 
-When the fix is ready, the security advisory and patches are sent
+When the fix is ready, send the security advisory and patches
 to downstream stakeholders
 (`security-prerelease@dpdk.org <mailto:security-prerelease@dpdk.org>`_),
 specifying the date and time of the end of the embargo.
-The communicated public disclosure date should be **less than one week**
+The communicated public disclosure date should be **less than one week**.
 
 Downstream stakeholders are expected not to deploy or disclose patches
-until the embargo is passed, otherwise they will be removed from the list.
+until the embargo passes; otherwise they will be removed from the list.
 
 Downstream stakeholders (in `security-prerelease list
-<https://mails.dpdk.org/roster/security-prerelease>`_), are:
+<https://mails.dpdk.org/roster/security-prerelease>`_) are:
 
 * Operating system vendors known to package DPDK
 * Major DPDK users, considered trustworthy by the technical board, who
   have made the request to `techboard@dpdk.org <mailto:techboard@dpdk.org>`_
 
-The `OSS security private mailing list mailto:distros@vs.openwall.org>` will
+The `OSS security private mailing list <mailto:distros@vs.openwall.org>`_ will
 also be contacted one week before the end of the embargo, as indicated by `the
-OSS-security process <https://oss-security.openwall.org/wiki/mailing-lists/distros>`
+OSS-security process <https://oss-security.openwall.org/wiki/mailing-lists/distros>`_
 and using the PGP key listed on the same page, describing the details of the
 vulnerability and sharing the patch[es]. Distributions and major vendors follow
 this private mailing list, and it functions as a single point of contact for
 embargoed advance notices for open source projects.
 
-The security advisory will be based on below template,
-and will be sent signed with a security team's member GPG key.
+The security advisory will be based on the template below,
+and will be sent signed with a security team member's GPG key.
 
 
 Pre-Release Mail Template
@@ -234,7 +224,7 @@ Pre-Release Mail Template
   Please do not make the issue public (or release public patches)
   before this coordinated embargo date.
 
-If the issue is leaked during the embargo, the same procedure is followed
+If the issue is leaked during the embargo, follow the same procedure
 with only a few days delay between the pre-release and the public disclosure.
 
 
@@ -242,9 +232,9 @@ Private Disclosure
 ------------------
 
 If a vulnerability is unintentionally already fixed in the public repository,
-a security advisory is sent to downstream stakeholders
+send a security advisory to downstream stakeholders
 (`security-prerelease@dpdk.org <mailto:security-prerelease@dpdk.org>`_),
-giving few days to prepare for updating before the public disclosure.
+giving a few days to prepare for updating before the public disclosure.
 
 
 Private Disclosure Mail Template
@@ -275,23 +265,23 @@ Private Disclosure Mail Template
 Public Disclosure
 -----------------
 
-On embargo expiration, following tasks will be done simultaneously:
+When the embargo expires, carry out the following actions simultaneously:
 
-* The assigned bug is filled by a member of the security team,
-  with all relevant information, and it is made public.
-* The patches are pushed to the appropriate branches.
-* For long and short term stable branches fixed,
-  new versions should be released.
+* A security team member files the assigned bug with all relevant details and makes it publicly accessible.
 
-Releases on Monday to Wednesday are preferred, so that system administrators
-do not have to deal with security updates over the weekend.
+* Push the associated patches to the appropriate branches.
 
-The security advisory is posted
+* Release updated versions for all affected stable branches, both short-term and long-term.
+
+To ease adoption by system administrators, preferably schedule security releases
+between Monday and Wednesday, avoiding weekends.
+
+Post the security advisory
 to `announce@dpdk.org <mailto:announce@dpdk.org>`_ and to `the public OSS-security
-mailing list <mailto:oss-security@lists.openwall.com>` as soon as the patches
+mailing list <mailto:oss-security@lists.openwall.com>`_ as soon as the patches
 are pushed to the appropriate branches.
 
-Patches are then sent to `dev@dpdk.org <mailto:dev@dpdk.org>`_
+Send patches to `dev@dpdk.org <mailto:dev@dpdk.org>`_
 and `stable@dpdk.org <mailto:stable@dpdk.org>`_ accordingly.
 
 
-- 
2.51.0

