Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FEAC83F34
	for <dpdk-dev@archiver.kernel.org>; Sat, 19 Jul 2025 15:00:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 20ED3402AE;
	Sat, 19 Jul 2025 17:00:22 +0200 (CEST)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com
 [209.85.222.174])
 by mails.dpdk.org (Postfix) with ESMTP id 12C46402B5
 for <dev@dpdk.org>; Sat, 19 Jul 2025 06:22:03 +0200 (CEST)
Received: by mail-qk1-f174.google.com with SMTP id
 af79cd13be357-7dfff5327fbso366585885a.1
 for <dev@dpdk.org>; Fri, 18 Jul 2025 21:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752898922; x=1753503722; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MO8Ovs5+YjakMDVolgvlDCfnIJHocIWRr9Sz4th0d24=;
 b=DRdW7ne757t474tc80JB5lmzZgHNi9FqH9qlsHiXl8aOYg9Ozn6NFjw1C5lKZdW3pI
 zc/mMOUWodP1PGTPnqYm7pPx6D7Yvt441vhGj+/bCQiAfcpbggnRXgUkuMdCZLgddx2Q
 CT2l8H+10qiCGRAV0XeSxRQoorZ6jkvKE7W0vHTWHyPBhCDvcNOqdFb7Ma+A7E/qc51l
 Yf+ZffXsK5Ahuwu5yfbMkOjhxvStelT+Zi3z7XFrnX26Myk4vqnsRizD2eVfBw051Nxx
 GF2U3Z/wmFubxKLLQW7iD0HgrTwsLy/CD+rJ/PRE43lg37sM0v8aFbBqy4OqVjvXySJY
 HQiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752898922; x=1753503722;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MO8Ovs5+YjakMDVolgvlDCfnIJHocIWRr9Sz4th0d24=;
 b=BjUGTB5+/xwiBRR5a06WF+ehdXw/PhuwT0jCd2YRRjRwGYOAA3KzT8hJoOS0DJwCZ3
 aWVVynIBbwT2F6I5lSo1IZzxi4fNQ65R2ebvQIFEW5Q1HMDEaZ5og2J+27uv3+HtZNdi
 EuYQ6C3pCOBZs8GKoeh6nkqNIW2crvd2RuBmdU4IRRoO/SVHi4RbF55/TSN9h8yZsvOk
 rVkE2LDNFdo6sKrchqdKxfYnNgLJg4eraEdt8DVwkT3ckt62nzvBNi5iRGgD6KiBjedO
 Nt17ce1VfOitM+69FRM9UdpH18pkusz0cBSbgCW/SA2YgFhPivgxxiHkbxMyrSXu7eGb
 Jimw==
X-Gm-Message-State: AOJu0YxNn6uZ2gI/+iN3LIZnVbLaTnojzLqQ6ElE3KyJthQ4tvHyHcpf
 U7RcozeyTaoLwWxGBfZpJa2IIUNkvEmVA/vVdlWR14KZRprC8yY/7OOvZg6Nng==
X-Gm-Gg: ASbGncs6c8VTWmKlOCFjf7k3RmPFBCUTP0TIPfd/3juYQ0e1pcslSt+jmAOh28fn5IN
 AletIXzBmUhnUd9XUykaDJjZT28VXpCu6fEYyj9JzWqM64Jz9CVwPYIPtn+VZ/CSh40XzJSLjB1
 H6A3sqCM4Waeqpx4Tyf2zBpY8h1nqJqo8hVM2gox5i/Lo5m4mwRkHEezce1L36q6E2mXaSaKCxU
 133de0frnTLGXmrP9ApL9nIusvFffXMimRw7vJWdq160ed6pWxX7BxGIIFJdb3yZGpznapAiEya
 GTJuT8VVquuZDh++sTWnKC8UeKMwarKDVyIxldO91mC+FtfJnOsebFKHe5MPJTwnWCBVstUWPwk
 n0pWZHOACWSCh2otujFULiYJJvs/4SSiIeuPGoZTICtOJzYa8E+mNFOJ72yYD5K+3Bku7fQ==
X-Google-Smtp-Source: AGHT+IFVU8Deb+d0lFAcNbrsXW0UmOkMTaSuluPu8hqkNfluK6PYpL5K0T5duLbO9bm8etCFcGGdBg==
X-Received: by 2002:a05:620a:6582:b0:7e3:4525:4e07 with SMTP id
 af79cd13be357-7e3452556b3mr1389569185a.58.1752898921774; 
 Fri, 18 Jul 2025 21:22:01 -0700 (PDT)
Received: from pravin-HP-Z840.. (ool-944c2daf.dyn.optonline.net.
 [148.76.45.175]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e356b2a976sm162576285a.13.2025.07.18.21.22.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jul 2025 21:22:01 -0700 (PDT)
From: Pravin Pathak <pravinpathakdev@gmail.com>
X-Google-Original-From: Pravin Pathak <pravin.pathak.dev@gmail.com>
To: dev@dpdk.org
Cc: jerinj@marvell.com, bruce.richardson@intel.com, thomas@monjalon.net,
 Pravin Pathak <pravin.pathak.dev@gmail.com>
Subject: [PATCH v2] mailmap: add new email to DPDK
Date: Sat, 19 Jul 2025 00:21:58 -0400
Message-ID: <20250719042158.39269-1-pravin.pathak.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714191141.1243467-1-pravin.pathak@intel.com>
References: <20250714191141.1243467-1-pravin.pathak@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 19 Jul 2025 17:00:19 +0200
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

Adding new mail for DPDK contribution

Signed-off-by: Pravin Pathak <pravin.pathak.dev@gmail.com>
---
 .mailmap | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index c7d55c7386..1c5c367f6c 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1240,7 +1240,7 @@ Prateek Agarwal <prateekag@cse.iitb.ac.in>
 Prathisna Padmasanan <prathisna.padmasanan@intel.com>
 Praveen Kaligineedi <pkaligineedi@google.com>
 Praveen Shetty <praveen.shetty@intel.com>
-Pravin Pathak <pravin.pathak@intel.com>
+Pravin Pathak <pravin.pathak.dev@gmail.com>
 Prince Takkar <ptakkar@marvell.com>
 Priyalee Kushwaha <priyalee.kushwaha@intel.com>
 Priyanka Jain <priyanka.jain@nxp.com>
-- 
2.43.0

