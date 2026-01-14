Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69920D3CC86
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 22:26:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9DCAC41157;
	Wed, 14 Jan 2026 23:25:34 +0100 (CET)
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
 [209.85.128.66]) by mails.dpdk.org (Postfix) with ESMTP id 271294113C
 for <dev@dpdk.org>; Wed, 14 Jan 2026 23:25:33 +0100 (CET)
Received: by mail-wm1-f66.google.com with SMTP id
 5b1f17b1804b1-477619f8ae5so2164375e9.3
 for <dev@dpdk.org>; Wed, 14 Jan 2026 14:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768429533;
 x=1769034333; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wEZteMprm4OyohcofE544KFrPU+Xquwxm4/HK0tAdAk=;
 b=O0iNDJF0QRqSWa1l6QPIFqOzc0/7yjWiLts2uXWR1KTeGTif34HHN+oKJEq+yFz63f
 St8Jv7XYDk3pX0zb4EglynLnI1PwuveOA6uf1iLLHa2dI/wgYFNPZ424g6D/xKfTBYlh
 VIu4xsad2VYphoY2K9zt1yHlYyZAHO4TkRD7eO3SP8ZaiBw/dyU42TCL5CGUE13kDuuw
 8WRzrFdpW+ILCjuKCbsbQqxx/oki7SAn02k+b36CrcgA8lA9/Pq2+UlCXxVRmUBFeMmu
 Q0TBYQnIP29wEbIuy7dv7vrCvbW0mHRoZgvhl/zV8wlE4DsGExg/W8gQZ1anKo8I57ho
 fYVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768429533; x=1769034333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wEZteMprm4OyohcofE544KFrPU+Xquwxm4/HK0tAdAk=;
 b=rP7F6S6VlGVWqZiNCjrjwzHGQCneuKyapCBpXceN6p//tY8nK04SSUO5cb6hPTnTck
 r7A62ThNCTWR3mJZUFGUcbLGDcyvrSm3SCN/oV+pEdAYDGiXMO5k8nLhN5ymuP7Mih6Q
 wQjBBUbrY7BCr13etzkh8DGAiCN4e2HEPw7+MsfW2zq06P6z+kgyUS57pwRJnOnfx431
 0ozsinw33L/sd1Y+eStMJBLpAuro994RXy8FrhoI+Th8or++wgAfjKvTZSHU62Iwohrk
 YqybVP6Z4ptIB+K4y4Wgbg/SPU2Pm8oEmmxm9lAnQt/8UDZ2zCJsAQP+2CR+TG40refR
 KsyQ==
X-Gm-Message-State: AOJu0YwYuXf2Ohmd9hraa9Igzh/+4AIVs4SrNS+ruJdjhCgh1hjmeKE+
 0jdv9tqQQBZ6a350e5foIVOOshQbJCq8meH8tuubOJP0Wg93nPbM8yS9T5GJs8OXa4aypLjnaHG
 P7wvr
X-Gm-Gg: AY/fxX5LktbWKV10qxMopWflXf+li55cUT901dlQ3ff0X5TRSQHOEKInfoD6mXnBZ33
 kgY0LNpwp8INJ1/DP2FpeDZJnrjfKCV7FcZD7aXHMNdALpYnjt/9F6ARH2Stfs0IRXm70Oeudvj
 h2g4SfCSspVDy4sau1WamerMM1oq52B47IzxOlaKL0dcKeUqfOU7uUHx1B5JVXdkfq887xIi6KT
 SrG3rmD9Pf9CtOj5GpKE0QsX0AMfKdzwMBZ+bJhzgS7QUSUxZtF6LBeEQMmAxA5d6wj9eTVzCIj
 WY75Kw7lGmG5k2NRivv01fQWNyWaLpZ+aQaXY2Lh3MEtLMYMjSoVmRg+ZrcEiqhg9ZESMBESUFq
 nC9fHfyq9/gS7kpyp0Z5QyiHl8SIyGo4zI7wen9XqL07H1rL/LpT+lmBB3rhcipQvBhBw4pJIn9
 dyAgaLKvk86Z0YHMzm/VKk1CDWvqqciiVjb7gRvTjlERds7AlJOg==
X-Received: by 2002:a05:600c:500d:b0:47d:3ffb:16c9 with SMTP id
 5b1f17b1804b1-47ee33917d1mr42095025e9.23.1768429532692; 
 Wed, 14 Jan 2026 14:25:32 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f42907141sm12040355e9.9.2026.01.14.14.25.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 14:25:32 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
Subject: [PATCH 17/29] doc/guides: improve FIPS validation sample app guide
Date: Wed, 14 Jan 2026 14:21:58 -0800
Message-ID: <20260114222458.87119-18-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114222458.87119-1-stephen@networkplumber.org>
References: <20260114222458.87119-1-stephen@networkplumber.org>
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

Improve the FIPS validation sample application documentation:
- restructure CAVP and ACVP as subsections under Limitations
- fix indentation of code blocks and bullet lists
- improve grammar and clarify explanations
- use consistent formatting for options

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/sample_app_ug/fips_validation.rst | 117 ++++++++++---------
 1 file changed, 60 insertions(+), 57 deletions(-)

diff --git a/doc/guides/sample_app_ug/fips_validation.rst b/doc/guides/sample_app_ug/fips_validation.rst
index 613c5afd19..4c96452b65 100644
--- a/doc/guides/sample_app_ug/fips_validation.rst
+++ b/doc/guides/sample_app_ug/fips_validation.rst
@@ -17,32 +17,35 @@ Automated Crypto Validation Protocol (ACVP) test vectors.
 
 For an algorithm implementation to be listed on a cryptographic module
 validation certificate as an Approved security function, the algorithm
-implementation must meet all the requirements of FIPS 140-2 (in case of CAVP)
-and FIPS 140-3 (in case of ACVP) and must successfully complete the
+implementation must meet all the requirements of FIPS 140-2 (in the case of CAVP)
+and FIPS 140-3 (in the case of ACVP) and must successfully complete the
 cryptographic algorithm validation process.
 
 Limitations
 -----------
 
+The following sections describe limitations for CAVP and ACVP.
+
 CAVP
-----
+~~~~
 
 * The version of request file supported is ``CAVS 21.0``.
-* If the header comment in a ``.req`` file does not contain a Algo tag
-  i.e ``AES,TDES,GCM`` you need to manually add it into the header comment for
-  example::
+* If the header comment in a ``.req`` file does not contain an Algo tag
+  (i.e., ``AES,TDES,GCM``), you need to manually add it into the header comment.
+  For example::
 
       # VARIABLE KEY - KAT for CBC / # TDES VARIABLE KEY - KAT for CBC
 
 * The application does not supply the test vectors. The user is expected to
-  obtain the test vector files from `CAVP
-  <https://csrc.nist.gov/projects/cryptographic-algorithm-validation-
-  program/block-ciphers>`_ website. To obtain the ``.req`` files you need to
+  obtain the test vector files from the `CAVP
+  <https://csrc.nist.gov/projects/cryptographic-algorithm-validation-program/block-ciphers>`_
+  website. To obtain the ``.req`` files, you need to
   email a person from the NIST website and pay for the ``.req`` files.
   The ``.rsp`` files from the site can be used to validate and compare with
   the ``.rsp`` files created by the FIPS application.
 
-* Supported test vectors
+* Supported test vectors:
+
     * AES-CBC (128,192,256) - GFSbox, KeySbox, MCT, MMT
     * AES-GCM (128,192,256) - EncryptExtIV, Decrypt
     * AES-CCM (128) - VADT, VNT, VPT, VTT, DVPT
@@ -52,12 +55,14 @@ CAVP
       VarText
 
 ACVP
-----
+~~~~
 
 * The application does not supply the test vectors. The user is expected to
-  obtain the test vector files from `ACVP  <https://pages.nist.gov/ACVP>`_
+  obtain the test vector files from the `ACVP <https://pages.nist.gov/ACVP>`_
   website.
-* Supported test vectors
+
+* Supported test vectors:
+
     * AES-CBC (128,192,256) - AFT, MCT
     * AES-GCM (128,192,256) - AFT
     * AES-CCM (128,192,256) - AFT
@@ -78,74 +83,72 @@ ACVP
 Application Information
 -----------------------
 
-If a ``.req`` is used as the input file after the application is finished
-running it will generate a response file or ``.rsp``. Differences between the
-two files are, the ``.req`` file has missing information for instance if doing
-encryption you will not have the cipher text and that will be generated in the
-response file. Also if doing decryption it will not have the plain text until it
-finished the work and in the response file it will be added onto the end of each
-operation.
-
-The application can be run with a ``.rsp`` file and what the outcome of that
-will be is it will add a extra line in the generated ``.rsp`` which should be
-the same as the ``.rsp`` used to run the application, this is useful for
-validating if the application has done the operation correctly.
+If a ``.req`` file is used as the input file, after the application finishes
+running it generates a response file (``.rsp``). The differences between
+the two files are as follows: the ``.req`` file has missing information (for instance,
+if performing encryption, you do not have the cipher text, and that is
+generated in the response file); and if performing decryption, it does not
+have plain text until the work has finished. In the response file, this information
+is added onto the end of each operation.
 
+The application can be run with a ``.rsp`` file as input. The outcome is that
+an extra line in the generated ``.rsp`` file is added. This should be the same
+as the ``.rsp`` used to run the application. This is useful for validating if
+the application has performed the operation correctly.
 
 Compiling the Application
 -------------------------
 
-* Compile Application
+To compile the sample application, see :doc:`compiling`.
 
-    To compile the sample application see :doc:`compiling`.
+Run ``dos2unix`` on the request files:
 
-*  Run ``dos2unix`` on the request files
-
-    .. code-block:: console
+.. code-block:: console
 
-         dos2unix AES/req/*
-         dos2unix GCM/req/*
-         dos2unix CCM/req/*
-         dos2unix CMAC/req/*
-         dos2unix HMAC/req/*
-         dos2unix TDES/req/*
-         dos2unix SHA/req/*
+     dos2unix AES/req/*
+     dos2unix GCM/req/*
+     dos2unix CCM/req/*
+     dos2unix CMAC/req/*
+     dos2unix HMAC/req/*
+     dos2unix TDES/req/*
+     dos2unix SHA/req/*
 
 Running the Application
 -----------------------
 
 The application requires a number of command line options:
 
-    .. code-block:: console
+.. code-block:: console
+
+     ./dpdk-fips_validation [EAL options]
+     -- --req-file FILE_PATH/FOLDER_PATH
+     --rsp-file FILE_PATH/FOLDER_PATH
+     [--cryptodev DEVICE_NAME] [--cryptodev-id ID] [--path-is-folder]
+     --mbuf-dataroom DATAROOM_SIZE
 
-         ./dpdk-fips_validation [EAL options]
-         -- --req-file FILE_PATH/FOLDER_PATH
-         --rsp-file FILE_PATH/FOLDER_PATH
-         [--cryptodev DEVICE_NAME] [--cryptodev-id ID] [--path-is-folder]
-         --mbuf-dataroom DATAROOM_SIZE
+where:
 
-where,
-  * req-file: The path of the request file or folder, separated by
+*   req-file: The path of the request file or folder, separated by the
     ``path-is-folder`` option.
 
-  * rsp-file: The path that the response file or folder is stored. separated by
+*   rsp-file: The path that the response file or folder is stored, separated by the
     ``path-is-folder`` option.
 
-  * cryptodev: The name of the target DPDK Crypto device to be validated.
+*   cryptodev: The name of the target DPDK Crypto device to be validated.
 
-  * cryptodev-id: The id of the target DPDK Crypto device to be validated.
+*   cryptodev-id: The ID of the target DPDK Crypto device to be validated.
 
-  * path-is-folder: If presented the application expects req-file and rsp-file
-    are folder paths.
+*   path-is-folder: If present, the application expects req-file and rsp-file
+    to be folder paths.
 
-  * mbuf-dataroom: By default the application creates mbuf pool with maximum
-    possible data room (65535 bytes). If the user wants to test scatter-gather
-    list feature of the PMD he or she may set this value to reduce the dataroom
+*   mbuf-dataroom: By default, the application creates an mbuf pool with maximum
+    possible data room (65535 bytes). If the user wants to test the scatter-gather
+    list feature of the PMD, this value can be set to reduce the dataroom
     size so that the input data may be divided into multiple chained mbufs.
 
 
-To run the application in linux environment to test one AES FIPS test data
-file for crypto_aesni_mb PMD, issue the command:
+To run the application in a Linux environment to test one AES FIPS test data
+file for the crypto_aesni_mb PMD, issue the command:
 
 .. code-block:: console
 
@@ -153,8 +156,8 @@ file for crypto_aesni_mb PMD, issue the command:
     --req-file /PATH/TO/REQUEST/FILE.req --rsp-file ./PATH/TO/RESPONSE/FILE.rsp
     --cryptodev crypto_aesni_mb
 
-To run the application in linux environment to test all AES-GCM FIPS test
-data files in one folder for crypto_aesni_gcm PMD, issue the command:
+To run the application in a Linux environment to test all AES-GCM FIPS test
+data files in one folder for the crypto_aesni_gcm PMD, issue the command:
 
 .. code-block:: console
 
-- 
2.51.0

