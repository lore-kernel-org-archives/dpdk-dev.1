Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8223BC77B7C
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Jul 2025 16:23:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 90E0D40ED2;
	Wed,  2 Jul 2025 18:23:40 +0200 (CEST)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com
 [209.85.222.182])
 by mails.dpdk.org (Postfix) with ESMTP id 2750440E50
 for <dev@dpdk.org>; Wed,  2 Jul 2025 18:23:38 +0200 (CEST)
Received: by mail-qk1-f182.google.com with SMTP id
 af79cd13be357-7d094ef02e5so11293685a.1
 for <dev@dpdk.org>; Wed, 02 Jul 2025 09:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1751473417; x=1752078217; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A2t7Cffdv+DkVaOABrEQ/BpskXPK2lbQy4ds4qk1JOQ=;
 b=RWOBoMbn7x2gsunWCMo41SzS0NiQ7fxk4EGJquz5VJONOJY12vlCSAnTyUZlQthAEp
 vI3+aE2hHWmZ/Uggso8vejyunUpjy1rFwGjZ8sQTyWvaWsR3T7L+NE54wcIwSbtdHMWL
 Dj0FjnZTaBEqhNKqlcfMpBQF5yeUSYsWNYJdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751473417; x=1752078217;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A2t7Cffdv+DkVaOABrEQ/BpskXPK2lbQy4ds4qk1JOQ=;
 b=sopo+C+kz9BxHZ/pQ2rPeHBkMsuJgN24ixkO/m0RXIJ/OxvbXJrk19PMErX/od5mi+
 PTq4vKCyj1hV97uRcuIoiIiLDfsO0FLilBtUzbu6qkhUr0pe8ivKl2V0uUflzoSAiZhs
 ayVKcmaDFUI4HIVlx2KfHKAFP+e+lrI5z9De1DVZQB23ZcbICy8+LOn7Q7KKcH3dZcZK
 Qb7RQA9p52DWjwQ207GkQKkO2xUlt7XxaoADXy3VP2Y4cG4QoR0LtGfLoBUWbr1exArf
 /h7dkFI4KufokUsDLvZ70WgcIZqNwTv0KBmSl2ZYX6am5PwrhleMEZl5V51s57OMIULO
 6R/Q==
X-Gm-Message-State: AOJu0Yx+skUSaNdfeWl/rlJZb+ew5O6y17d0TvF/bE4315Ku5ZudBeKB
 7CBaUKsMC7/dt1jqbORB2LGZwgrKJR1LCRIWMfWX84Ki9oScOj564bPqqal5T4iBmKo=
X-Gm-Gg: ASbGnctD2s+6RKKM3HvcGvTde4ynvQQP4w48DblUkUdoM8ntYt0Ummz7rq1q2RKU0nJ
 T8ZNclA4nwPkP3Q+SpvKtqUsjYP8ljDEd6x5fZ5+fSHD0IMET5OKxH7ULtKgs1U4FR0o84L6dQG
 6r7bQMHh9M7ksi7SXKoqcWl8dnFPDe3MMP2/qEfoPoM9yxjk0WWmdPPeiWbP2YVNfnryQPezIFW
 tHOH5zYwPzN7ePTNQzi+3zfDAmZmKjuu2gTp79D6f4mHSUPZ5YBa8F6mM2HrsEXUAsjc/mbQKOy
 pifH/4zd5n/YKBwKXXttSEv2w3g4HJIho1ES27jiuxBGh9wXIIWXh/IIJp/hOz79wovOnmJ3
X-Google-Smtp-Source: AGHT+IEfkVYUNu032NTrRSKRI5SUa0uN1yp89y5M209SF2nyokpWHdS329PyIrdCMh1iOKDjh10pcQ==
X-Received: by 2002:a05:620a:4013:b0:7d3:89c7:684d with SMTP id
 af79cd13be357-7d5d14e9840mr17485085a.20.1751473417366; 
 Wed, 02 Jul 2025 09:23:37 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:ac5d:4186:4dc6:47eb])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d44316585dsm966947785a.28.2025.07.02.09.23.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 09:23:36 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v3 4/4] dts: add sr-iov section to docs
Date: Wed,  2 Jul 2025 12:23:31 -0400
Message-ID: <20250702162331.352313-4-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702162331.352313-1-dmarx@iol.unh.edu>
References: <20250626152755.197560-3-dmarx@iol.unh.edu>
 <20250702162331.352313-1-dmarx@iol.unh.edu>
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

Add a section to the dts.rst file explaining how to
enable SR-IOV mode on an environment, as well
as any additional steps needed for virtual
function configuration.

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
---
 doc/guides/tools/dts.rst | 46 ++++++++++++++++++++++++++++++++++++++++
 dts/README.md            |  2 +-
 2 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/doc/guides/tools/dts.rst b/doc/guides/tools/dts.rst
index 7e68159571..5dd858a7c8 100644
--- a/doc/guides/tools/dts.rst
+++ b/doc/guides/tools/dts.rst
@@ -217,6 +217,52 @@ There are two areas that need to be set up on a System Under Test:
 
       sudo usermod -aG sudo <sut_user>
 
+#. **SR-IOV**
+
+   Before configuring virtual functions, SR-IOV support must be enabled in the system BIOS/UEFI:
+
+   #. Reboot the system and enter BIOS/UEFI settings.
+   #. Locate the SR-IOV option (often under PCIe or Advanced settings).
+   #. Set SR-IOV to **Enabled** and save changes.
+
+   For Mellanox environments, the following additional setup steps are required:
+
+   #. **Install mstflint tools** (if not already installed):
+
+      .. code-block:: bash
+
+         sudo apt install mstflint        # On Debian/Ubuntu
+         sudo yum install mstflint        # On RHEL/CentOS
+
+   #. **Start the MST service**:
+
+      .. code-block:: bash
+
+         sudo mst start
+
+   #. **List Mellanox devices**:
+
+      .. code-block:: bash
+
+         sudo mst status
+
+      This will output paths such as ``/dev/mst/mt4121_pciconf0`` and possibly additional functions (e.g., ``pciconf0.1``).
+
+   #. **Enable SR-IOV and configure number of VFs**:
+
+      .. code-block:: bash
+
+         sudo mlxconfig -d /dev/mst/mt4121_pciconf0 set SRIOV_EN=1 NUM_OF_VFS=8
+         sudo mlxconfig -d /dev/mst/mt4121_pciconf0.1 set SRIOV_EN=1 NUM_OF_VFS=8
+
+      Replace the device names with those matching your setup (from ``mst status``). The number of VFs can be adjusted as needed.
+
+   #. **Reboot the system**:
+
+      .. code-block:: bash
+
+         sudo reboot now
+
 
 Setting up Traffic Generator Node
 ---------------------------------
diff --git a/dts/README.md b/dts/README.md
index 224a7aa20b..73c56ec504 100644
--- a/dts/README.md
+++ b/dts/README.md
@@ -33,7 +33,7 @@ its own ports.
 3. DTS uses ssh key auth to control the nodes. Copy your ssh keys to the TG and SUT:
     ssh-copy-id dts@{your host}.
 
-For additional detail, please refer to [dts.rst](doc/guides/tools/dts.rst)
+For additional detail on how to set up a valid DPDK environment, please refer to [dts.rst](doc/guides/tools/dts.rst)
 
 # DTS Configuration
 
-- 
2.49.0

