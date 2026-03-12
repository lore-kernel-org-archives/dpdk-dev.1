Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD39106ACE9
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Mar 2026 20:35:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D872402AC;
	Thu, 12 Mar 2026 21:35:53 +0100 (CET)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com
 [209.85.222.176])
 by mails.dpdk.org (Postfix) with ESMTP id E7AA240275
 for <dev@dpdk.org>; Thu, 12 Mar 2026 21:35:51 +0100 (CET)
Received: by mail-qk1-f176.google.com with SMTP id
 af79cd13be357-8cd8d97aa2eso185229085a.3
 for <dev@dpdk.org>; Thu, 12 Mar 2026 13:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1773347751; x=1773952551; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ru8OYAnu7xQ8MTTp/UmJQn06AADhCRfqdyfFX3B3jA0=;
 b=IpgNUn1gtR1XchZgd5d0RiHc5NgFvkEyaNt72uwG9DQzNjb/2O7SbuNsLXY63Zm0Ns
 kTV4T+dyVWhzIPwBHo3V9XMKtMNAlBvXTIOqAO7w/kAufoBCdcT9SNKVbH0GmwkQWqCq
 FbopzLv5oRXDReQ/TMRFVJsSWw2R0eP3+KSz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773347751; x=1773952551;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ru8OYAnu7xQ8MTTp/UmJQn06AADhCRfqdyfFX3B3jA0=;
 b=RiVFruNHwDiCm0NbdKgAyNXlw86o+46DOQmUFN3GGnIbZhqkedO31hFLkZ8SY88w3V
 BMYLKetbY1qq01eHIsA12OX+GybUm+VJkcP9gkZ1L+ZYQaY4CKjlUN3fKnPH5j6RT40b
 Ul9vOLn5qXnMdGzq66m4Jqv9QCXapeyQ3b4E08+vy7ktbSdZPATRSmiUandkPBTs/ysK
 zWRZQOUDBLXkTXy5LKRGWy563p7VNkq+qw/G1hbr+VUWcrBLGL13pNpJqWFYjrg+BwNQ
 ep5Pb+M17ElrLFFa+/4Mgo7lnHiLswtbTYRRrIjbeK1ktL4FTaZSUxxV/aPbsS8iIFSl
 aSTw==
X-Gm-Message-State: AOJu0YxHprmB/JNU6NI8YBZmYxwz5/o4M4xa+80Gy5dVQUfPyhD+VscP
 Ade9oUH4leeOhFWhU3H2xvLnRW6t2BZKJNLsiwDY+Fwq3k9hbsDBEb1VaCoI9yhf86k=
X-Gm-Gg: ATEYQzz2uaMIZpZX0THRBhwfa4nIUyH3lZsK3CCU8ZUDmsdzE32ZDcB4+fUvOQWhOqu
 9cqPWTcfFt/9UYO+4Sxp3Rx6cDL6ol2aVhLQAYj8rVrbbG1Sh9SYZ8wkaANMD4vuv8xU3Otu4jo
 qBJziZwcDtVSZkyBsxxH9V4L26uZVM6pPG+TjRmYEYF8lqR82KOZRtWDl/Agyp2ej9ZZhVYrAO0
 e/Uc1CUooIsjemp/zzDOYLr/Z+HKBMx4ZhfRxctMU+q9iJ6L7sQA6EXCx6IyahOnFrkUkuy436Y
 ymGd04vvFhnpgNMuLFxQNVjaKSPN0D+crnrlwYbl1tYTnE8pHextjl3j1Y2hnm240PuO1/nl5Dq
 LyH1w9FUT7kbdNUqUNSZbrYSBwbucFQM5eXdF5RAdwB2TFqiemld2xlCAM7MTkNFBbspsyQcd6w
 4wgemxXeNXOMBIS6hHJl8C+b33eplc3+WiV459z65OaBULl2KbQV3mOOXhsupH9A==
X-Received: by 2002:a05:620a:2948:b0:8cd:988e:c946 with SMTP id
 af79cd13be357-8cdb5a86ec4mr158297085a.24.1773347751096; 
 Thu, 12 Mar 2026 13:35:51 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:ac5d:4186:4dc6:47eb])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cda1fddfe8sm406560685a.12.2026.03.12.13.35.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 13:35:50 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v7 1/2] dts: update verbose output regex for VXLAN packets
Date: Thu, 12 Mar 2026 16:35:47 -0400
Message-ID: <20260312203548.96081-1-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.52.0
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

The packet regex in extract_verbose_output could not
match verbose output from tunnel protocols like
VXLAN because it did not allow commas. VXLAN
verbose lines contain comma-separated fields,
which caused the regex to fail before reaching
the final field. This silently dropped the entire
packet from the parsed output. Added comma and
dot to the allowed characters in the regex.

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
---
 dts/api/testpmd/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dts/api/testpmd/__init__.py b/dts/api/testpmd/__init__.py
index 703cae487e..bbcec7f969 100644
--- a/dts/api/testpmd/__init__.py
+++ b/dts/api/testpmd/__init__.py
@@ -817,7 +817,7 @@ def extract_verbose_output(output: str) -> list[TestPmdVerbosePacket]:
         prev_header: str = ""
         iter = re.finditer(
             r"(?P<HEADER>(?:port \d+/queue \d+: (?:received|sent) \d+ packets)?)\s*"
-            r"(?P<PACKET>src=[\w\s=:-]+?ol_flags: [\w ]+)",
+            r"(?P<PACKET>src=[\w\s=:,.-]+?ol_flags: [\w ]+)",
             output,
         )
         for match in iter:
-- 
2.52.0

