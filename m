Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C249606D803
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Nov 2026 17:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UmF3gcJQ
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0EBCA4278B;
	Thu,  5 Nov 2026 18:20:23 +0100 (CET)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by mails.dpdk.org (Postfix) with ESMTPS id A951440E09
 for <dev@dpdk.org>; Thu,  5 Nov 2026 18:20:21 +0100 (CET)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a214af2076so15932635e9.0
 for <dev@dpdk.org>; Thu, 05 Nov 2026 09:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793899221; x=1794504021; darn=dpdk.org;
 h=content-transfer-encoding:reply-to:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=uow+EqVm2agjbhjQQZOV9rtaNY3K8fav8oOvhq4RXCY=;
 b=UmF3gcJQsk2PP5U1zNLl4bGmzR/6om6M+V4jJGmlRKCOZovcnfMDJ81S2uvyrongC3
 4JAy5lg+c2aEz8+tKVVoO6pwATCPd6a8QEqhtlhfRLfQgNhPbOkxPhd/5Mgcsp9c8dz/
 TkYu85/ZMylsD9es47f5unpkNNvxbiccJrMzXmkKD91YOUa3D8aWckNercxi2obl+FCW
 7XNV6VudAF9re64EHQ+d+3F2UpG0CuidGW6r1V03vX2AJO8I0BP/cgWFPyHeKmSAVVDd
 GqHa9ElnBtyEBUszdXr7F3u4fLxK7hsCha3YubTr77kHawwgrwIqiRPV6cW6X7MAy78r
 0IAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793899221; x=1794504021;
 h=content-transfer-encoding:reply-to:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uow+EqVm2agjbhjQQZOV9rtaNY3K8fav8oOvhq4RXCY=;
 b=aJ2x7R55TShyCIh6iMX7zwJe33skwD2vlsERJsgxuC9cz/wWKdrqLIMp8/4JTHbi2E
 cMT5nZhE33ITVOtVwpjx9LH3Jq+j0eZ5rFjJF5NGtD2cCXRKM+wRnxAbdlHCji/dCVWu
 sNK3vmCy7Y5EA/d2aIN67jMdHX94kc+/n34RsCbZb/4tLsCRL2WwUD8RtspHDHuSn8sa
 yOhdAo/u7YIwUFkTtRnULnk8tlEmhoomb4+GJm46yxju8Kei8u1GarH2mF5+prR3hWks
 kx3l6LBCCq8gQxEqp1sDo2GWZ43v1dDHYxFgnrR/5WEq/+aSmyqUOTumcUFvtCP9SpTM
 Koug==
X-Gm-Message-State: APuU4Z+IPQ+sMx18gOvOCbC+PPu01qJGCDmuOGTa1FR2eCppw9PveewU
 ycbf9Bpnn5PaDw1A/0kzXGjpbZM524cOPe9/5PkgZ5MwyMp0awkYhYUq
X-Gm-Gg: AYBFou2IW/1TBgluEPJs+63EheJO375JWlXTm8UKqfHA1leTDB5vgd0KUwyeIfjGeyQ
 F2yD0B6qrbp5eiq5KRcMSGEdBikVS8CET0jvCgHneirNCcg0ma0hjQhe+cM1+OEXMK+LrH+RSN1
 j7wO3GlX1UuJWCYiKY0CUU2237Te/1Jme6lBfnqqUyPGZltmRFlK70+VUyOInE+Z2k1vVpk0ff1
 /Yyu6Hup7FZfdRDkSxq2/cMBjZsW166UNfG+Rd2aqRSogPDTA0W+Ggt1e7j0pTVKDSO2y9PgZw4
 v40gNunXeeKaB1L7DE2L4PSOHHuBbtaYrLDiZg20lRftm2STsBcl9E5J+PshNVCM0xaaKq3l5/w
 aqgjN0at5gbP3pWAD0FBHRYASnsVB53qmzuJBIAW0VULPtvg3GSLsVjx1OHfNnITvMAmfsMpd5r
 ruuNt6+SgspTqZaoFtpp+LNzL4thnU7cMQO309lZBjkU4CoiZd7hYakpcFx7/LfBBGMM+h9ovZP
 6zr6w0QnLTT6ltxD0Pxph4nJH3H4g3tIr6p6RHPoHMUGrCby8O0j02NmAlSsBPvfchCWwMpPEwK
 a+Nw4rbYGARBsvaISxTkhRnIOd6S6MDjUVO05RkdfhvV+jjLVgkkqSo=
X-Received: by 2002:a05:600c:190f:b0:4a2:1a:a11d with SMTP id
 5b1f17b1804b1-4ac1275c26emr419375835e9.0.1793899220872; 
 Thu, 05 Nov 2026 09:20:20 -0800 (PST)
Received: from localhost ([2a01:4b00:d036:ae00:897c:ca78:3de4:41e8])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4b571f46489sm76137165e9.3.2026.11.05.09.20.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 09:20:19 -0800 (PST)
From: luca.boccassi@gmail.com
To: dpdk stable <stable@dpdk.org>
Cc: dev@dpdk.org, Akhil Goyal <gakhil@marvell.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Anoob Joseph <anoobj@marvell.com>, Anurag Mandal <anurag.mandal@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Chengwen Feng <fengchengwen@huawei.com>,
 Ciara Loftus <ciara.loftus@intel.com>,
 David Marchand <david.marchand@redhat.com>,
 Erik Gabriel Carrillo <erik.g.carrillo@intel.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>, Gagandeep Singh <g.singh@nxp.com>,
 Geoff Thorpe <geoff.thorpe@nxp.com>, Harman Kalra <hkalra@marvell.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Jun Yang <jun.yang@nxp.com>,
 mb@smartsharesystems.com, Ori Kam <orika@nvidia.com>,
 Qiming Yang <qiming.yang@intel.com>, Qi Zhang <qi.z.zhang@intel.com>,
 Rohit Raj <rohit.raj@nxp.com>, Roy Pledge <roy.pledge@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Shaiq Wani <shaiq.wani@intel.com>,
 Shreyansh Jain <shreyansh.jain@nxp.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Volodymyr Fialko <vfialko@marvell.com>
Subject: please help backporting some patches to stable release 24.11.9
Date: Thu,  5 Nov 2026 17:20:10 +0000
Message-ID: <20261105172011.1419239-1-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Reply-To: dpdk stable <stable@dpdk.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi commit authors (and maintainers),

Despite being selected by the DPDK maintenance tool ./devtools/git-log-fixes.sh
I didn't apply following commits from DPDK main to 24.11
stable branch, as conflicts or build errors occur.

Can authors check your patches in the following list and either:
    - Backport your patches to the 24.11 branch, or
    - Indicate that the patch should not be backported

Please do either of the above by 2026-11-10.

You can find the a temporary work-in-progress branch of the coming 24.11.9
release at:
    https://github.com/bluca/dpdk-stable
It is recommended to backport on top of that to minimize further conflicts or
misunderstandings.

Some notes on stable backports:

A backport should contain a reference to the DPDK main branch commit
in it's commit message in the following fashion:
    [ upstream commit <commit's dpdk main branch SHA-1 checksum> ]

For example:
    https://git.dpdk.org/dpdk-stable/commit/?h=18.11&id=d90e6ae6f936ecdc2fd3811ff9f26aec7f3c06eb

When sending the backported patch, please indicate the target branch in the
subject line, as we have multiple branches, for example:
    [PATCH 24.11] foo/bar: fix baz

With git format-patch, this can be achieved by appending the parameter:
    --subject-prefix='PATCH 24.11'

Send the backported patch to "stable@dpdk.org" but not "dev@dpdk.org".

FYI, branch 24.11 is located at tree:
   https://git.dpdk.org/dpdk-stable

Thanks.

Luca Boccassi

---
c8325b3939  Anatoly Burakov  ethdev: fix MACsec item support in flow conversion
b1ebf0fc1b  Anatoly Burakov  net/iavf: centralize memory management for flows
7495d45fb2  David Marchand   bus/fslmc: fix interrupt leak in DPIO cleanup
0e03411639  David Marchand   test: defer timer initialization
dd82d0e9c4  Jun Yang         bus/dpaa: fix hang on FQ shutdown
a5dd495b8e  Shaiq Wani       net/intel: fix idpf Tx payload corruption in split queue
670ead3dd1  Stephen Hemminger eal/linux: fix FD leak in alarm subsystem
8c8da52f31  Thomas Monjalon  eal: enforce internal API check with Clang 14
