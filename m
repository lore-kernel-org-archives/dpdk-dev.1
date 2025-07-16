Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C6EAC83F22
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Jul 2025 18:25:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 36826402E6;
	Wed, 16 Jul 2025 20:25:51 +0200 (CEST)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com
 [209.85.160.175])
 by mails.dpdk.org (Postfix) with ESMTP id 0624C402DF
 for <dev@dpdk.org>; Wed, 16 Jul 2025 20:25:50 +0200 (CEST)
Received: by mail-qt1-f175.google.com with SMTP id
 d75a77b69052e-4ab81d0169cso2414431cf.2
 for <dev@dpdk.org>; Wed, 16 Jul 2025 11:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1752690349; x=1753295149; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dIaMxZGcETMOFZjy0UxozkpeNgp9891hByePsFBK0xY=;
 b=H9Q4Tt+EkiLxE5wxfRCSIJ8XDX8knj+QlWYWhEp/Zob/hiXLNumior+Y0rlE4CgAEW
 uNv3KDjegmUp5dBGT/u3TwiDyFLj7RfAudkWTIHq+K9/wmm/wlofnxYxOGvZTZbKjuU8
 Nsnpm/QTnORf5ekFyIbtCNPyD/oGbHySpZ+Mg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752690349; x=1753295149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dIaMxZGcETMOFZjy0UxozkpeNgp9891hByePsFBK0xY=;
 b=HSyhxiPjRTjdPKjnL4UPkxL2iXMLBY2n6oy998qVn5TOSgXscx1mAJ7Hb3fihDZmvC
 ZXQOSm4n6Db1KRSVUEZ8q4R/Ug43rh3/prrD2RWCZjqLOudfUvHd6zS3F1mFCLZI+2S4
 G7b74YPiDPiedg+K2T96W3nr8/7f7OXR9OK8pGhba/jLho1f/84tMotcYKBDihLar1X2
 NsADCrxONov67Avs/JgBh7DIufHV+BVAIwGNCUaGTseGCbEmRWJ4JZXECgYD1gazcvL/
 B48lEVYM7iGwZCnMttv5qwmfzqy9UUQCSL2vEcn5CqOAkOdjwiNoeb3oXX5yZ0bbGexM
 ZWtw==
X-Gm-Message-State: AOJu0YyKe5Cat8Y4myEm30cFGOCg4e6pVo0oa0j/SEHavyQfL1ffJpkV
 Uy4NRBXquJpKr++7QBMGb1KIybqW63edzG6fbrF25U5fGPs25Xp/+I1I9V1vVgnTo4SXEMTyq85
 YRRLU
X-Gm-Gg: ASbGncvgeJus/LFUOYrDTr0dedhs2n7OzXaVIORTnuacRiDc14ZlKQDAUJSeg+pv1mw
 10dC/sRuLzhmslG0eMy2D8t8GJi2dEeH169RGTUo8bgxB9bzKVFka22tUEn0Q7cdgTLM0q+Suz2
 5BIPIbQ27oHSHqMSZa3K3RiUBp9cSNF8nsZTFBXdpu3XzYVIrmLLC9AhJ8kOicx4jR/1AyyGZ6v
 v4ubh0l9PH73uEhbVLVZTdkczp93Wa3fpPK8Exgu1Fc7xkuiN+vBWwcHZxOZqvqa8f8cZFg85qS
 I0pMK/BZqznT9fEj1vUGRE99D7oUBSe1OPR9FX/GEwkhYgyEDwvcYEEOJMzU6Gmm/rJXVfIiQsr
 2wL0QrcOrFnC63bG43Agy88pT47ldynDBTi9paUHwhohvdliVsiYGeJFjJH4tJs0=
X-Google-Smtp-Source: AGHT+IHge8jizC7XpP4sAIiOqfivvzikvEsdVV5CRg/a9AZ4AO4kJPOWSolwW+LTI6iXAzvveaO6gw==
X-Received: by 2002:a05:622a:790c:b0:4ab:63b9:5b8b with SMTP id
 d75a77b69052e-4ab909df00bmr56296981cf.13.1752690349099; 
 Wed, 16 Jul 2025 11:25:49 -0700 (PDT)
Received: from fedora.iol.unh.edu ([132.177.125.216])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ab70bc9e76sm33495321cf.64.2025.07.16.11.25.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 11:25:48 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v6 1/3] dts: rewrite README
Date: Wed, 16 Jul 2025 14:25:44 -0400
Message-ID: <20250716182546.58567-1-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250716135708.49233-1-dmarx@iol.unh.edu>
References: <20250716135708.49233-1-dmarx@iol.unh.edu>
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

Refactor README to contain only a high level description
of relevant DTS concepts and a simple getting started guide.

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
Reviewed-by: Patrick Robb <probb@iol.unh.edu>
Reviewed-by: Paul Szczepanek <paul.szczepanek@arm.com>
---
 dts/README.md | 116 ++++++++++++++++++++++++--------------------------
 1 file changed, 56 insertions(+), 60 deletions(-)

diff --git a/dts/README.md b/dts/README.md
index 2b3a7f89c5..106afdfbdb 100644
--- a/dts/README.md
+++ b/dts/README.md
@@ -1,67 +1,67 @@
-# DTS Environment
-
-The execution and development environments for DTS are the same,
-a [Docker](https://docs.docker.com/) container defined by our [Dockerfile](./Dockerfile).
-Using a container for the development environment helps with a few things.
-
-1. It helps enforce the boundary between the DTS environment and the TG/SUT,
-   something which caused issues in the past.
-2. It makes creating containers to run DTS inside automated tooling much easier, since
-   they can be based off of a known-working environment that will be updated as DTS is.
-3. It abstracts DTS from the server it is running on. This means that the bare-metal OS
-   can be whatever corporate policy or your personal preferences dictate,
-   and DTS does not have to try to support all distros that are supported by DPDK CI.
-4. It makes automated testing for DTS easier,
-   since new dependencies can be sent in with the patches.
-5. It fixes the issue of undocumented dependencies,
-   where some test suites require Python libraries that are not installed.
-6. Allows everyone to use the same Python version easily,
-   even if they are using a distribution or Windows with out-of-date packages.
-7. Allows you to run the tester on Windows while developing via Docker for Windows.
-
-## Tips for setting up a development environment
-
-### Getting a docker shell
-
-These commands will give you a bash shell inside the container
-with all the Python dependencies installed.
-This will place you inside a Python virtual environment.
-DTS is mounted via a volume, which is essentially a symlink from the host to the container.
-This enables you to edit and run inside the container
-and then delete the container when you are done, keeping your work.
-It is also strongly recommended that you mount your SSH keys into the container
-to allow you to connect to hosts without specifying a password.
-
-#### Start docker container with SSH keys
+# Description
+
+DTS is a testing framework and set of testsuites for end to end testing of DPDK and DPDK
+enabled hardware. Unlike DPDK's dpdk-test application, which is used for running unit tests,
+DTS is intended to be used to evaluate real DPDK workloads run over supported hardware. For instance,
+DTS will control a traffic generator node which will send packets to a system under test node which
+is running a DPDK application, and evaluate the resulting DPDK application behavior.
+
+# Supported Test Node Topologies
+
+DTS is a python application which will control a traffic generator node (TG) and system
+under test node (SUT). The nodes represent a DPDK device (usually a NIC) located on a
+host. The devices/NICs can be located on two separate servers, or on the same server. If you use
+the same server for both NICs, install them on separate NUMA domains if possible (this is ideal
+for performance testing.)
+
+- 2 links topology: Represents a topology in which the TG node and SUT node both have two network interfaces
+which form the TG <-> SUT connection. An example of this would be a dual interface NIC which is the
+TG node connected to a dual interface NIC which is the SUT node. Interface 0 on TG <-> interface 0
+on SUT, interface 1 on TG <-> interface 1 on SUT.
+- 1 link topology: Works, but may result in skips for testsuites which are explicitly decorated with a
+2 link requirement. Represents a topology in which the TG node and SUT node are connected over
+a single networking link. An example of this would be two single interface
+NICs directly connected to each other.
+
+# Simple Linux Setup
+
+1. On your TG and SUT nodes, add a dedicated user for DTS. In this example I
+    will name the user "dts."
+2. Grant passwordless sudo to the dts user, like so:
+    2a: enter 'visudo' in your terminal
+    2b: In the visudo text editor, add:
+        dts   ALL=(ALL:ALL) NOPASSWD:ALL
+3. DTS uses ssh key auth to control the nodes. Copy your ssh keys to the TG and SUT:
+    ssh-copy-id dts@{your host}.
+
+For additional detail, please refer to [dts.rst](../doc/guides/tools/dts.rst)
+
+# DTS Configuration
+
+DTS requires two yaml files to be filled out with information about your environment,
+test_run.yaml and nodes.yaml, which follow the format illustrated in the example files.
+
+1. Install Docker on the SUT, and Scapy on the TG.
+2. Create and fill out a test_run.yaml and nodes.yaml file within your dts
+    directory, based on the structure from the example config files.
+3. Run the bash terminal commands below in order to run the DTS container
+    and start the DTS execution.
 
 ```shell
 docker build --target dev -t dpdk-dts .
-docker run -v $(pwd)/..:/dpdk -v /home/dtsuser/.ssh:/root/.ssh:ro -it dpdk-dts bash
+docker run -v $(pwd)/..:/dpdk -v /home/{name of dts user}/.ssh:/root/.ssh:ro -it dpdk-dts bash
 $ poetry install
-$ poetry shell
+$ poetry run ./main.py
 ```
 
-#### Start docker container without SSH keys
+These commands will give you a bash shell inside a docker container
+with all DTS Python dependencies installed.
 
-```shell
-docker build --target dev -t dpdk-dts .
-docker run -v $(pwd)/..:/dpdk -it dpdk-dts bash
-$ poetry install
-$ poetry shell
-```
-
-### Vim/Emacs
-
-Any editor in the Ubuntu repos should be easy to use,
-with Vim and Emacs already installed.
-You can add your normal config files as a volume,
-enabling you to use your preferred settings.
-
-```shell
-docker run -v ${HOME}/.vimrc:/root/.vimrc -v $(pwd)/..:/dpdk -it dpdk-dts bash
-```
+## Visual Studio Code
 
-### Visual Studio Code
+Usage of VScode devcontainers is NOT required for developing on DTS and running DTS,
+but provide some small quality of life improvements for the developer. If you
+want to develop from a devcontainer, see the instructions below:
 
 VSCode has first-class support for developing with containers.
 You may need to run the non-Docker setup commands in the integrated terminal.
@@ -75,7 +75,3 @@ Additionally, there is a line in `.devcontainer/devcontainer.json` that, when in
 will mount the SSH keys of the user currently running VSCode into the container for you.
 The `source` on this line can be altered to mount any SSH keys
 on the local machine into the container at the correct location.
-
-### Other
-
-Searching for '$IDE dev containers' will probably lead you in the right direction.
-- 
2.50.1

