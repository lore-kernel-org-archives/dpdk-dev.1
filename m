Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43D8C5AD49
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 17:28:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7B81440E0A;
	Tue,  3 Jun 2025 19:28:31 +0200 (CEST)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com
 [209.85.219.49]) by mails.dpdk.org (Postfix) with ESMTP id 3A11840DCB
 for <dev@dpdk.org>; Tue,  3 Jun 2025 19:28:29 +0200 (CEST)
Received: by mail-qv1-f49.google.com with SMTP id
 6a1803df08f44-6facba680a1so62969676d6.3
 for <dev@dpdk.org>; Tue, 03 Jun 2025 10:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1748971709; x=1749576509; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QuIFIMo7KoKmblI2F/o2bKLFQrpwJGd3z3QSsGGZ/98=;
 b=VYKSMeJ92qga16aWGLZYNDkcJOc599le8TuuFP3E9YGbomVzGcZg4k5EGPLORAzjRH
 8LrY+x9hbsCnWevMVIzp8FttiZIHJKqgv3jkYZQFWJMMcgPlMouHz0P3sOibNCFbdgxU
 wLuyq8tT/H1NrGhOpshtLsxgLj5JWLmg05p3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748971709; x=1749576509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QuIFIMo7KoKmblI2F/o2bKLFQrpwJGd3z3QSsGGZ/98=;
 b=owZl2xhk7azLf6l77kmHd1HqsuNqOe4pvgOaXUaNVxVrzaNbbjx4sz9xqJNsKKAGKW
 dw/j7eyM7ThTo7utuaFYkHt/W234qbEKVphzpiXlXdPtisyrCwvB6/0oWSY7vxT/TN6m
 VokPQVWCBzPo3hDj/+vwgFN2eZD11Wt3eMK4rG8B/7TKKOQIlhWQi4OlfLdM4D5j6YqI
 Mj8nVL0tzxAvE0kwjHZ0uG7R7kS/7WNH6+Y2wuoXiYOarfmdM/90W9jb5UTKLX8GuzET
 YUD80ZUkSHe+ze0oFkAuI3B6s3XfZLqoVbS+V/hcj9wxI2l9J6eO+3YG5fsOdVMx8O4H
 xcYw==
X-Gm-Message-State: AOJu0YzkPDyXJ9yFxcMYqqOE214ObDYyq0nEiMfobjk1VclDeLjH9zZv
 +akOkp/411DpIBEiphnwiItydGJ3HMqXrVKg64mmQaiiwwIFRG9a94qC7qxVluvKOrk=
X-Gm-Gg: ASbGncuauzl8RttQ9eViTEAaDPvs6pLKpNNvHUDlgQFSVqsEu5aHOfXYakxJ8oQZg40
 LzaVbF0rgNmtr72XAR6hX8qa9/TEOPs7PUJHP45sgfbbpu4AMI8vI1+1Mg4BO3hd7zlh/fu2nRl
 XgGI9q1Cou1md6aSOfBG+vYPBLMPc4rguajqllQKLwB7pJ2Z3erMXZmL47C7kqMtNFz/14NCxhO
 J/o9eNm0mC8RVs1aJzGP0iGDmzjccmKad2XM6iXNyb33CziJCwB+AvWD/Xvh6aOGDFM6TWad+XM
 tOkPSNgVV6pXIkDDKPYY1OWNwWwienOgre1QrUbLo7KtRHeOYQCvo+T+kneKxJClsn4xIch7
X-Google-Smtp-Source: AGHT+IHG/2dawBHrYtCdHzmKSmiqpXTGy4/gmMOzRTMG2P9rtNQPUZd1B2WQZSoIRD961Y/1kDl16A==
X-Received: by 2002:a05:6214:4114:b0:6fa:cb58:10b7 with SMTP id
 6a1803df08f44-6fad913c2d1mr190772146d6.26.1748971709149; 
 Tue, 03 Jun 2025 10:28:29 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:ac5d:4186:4dc6:47eb])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fac6d3517bsm83564596d6.4.2025.06.03.10.28.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 10:28:28 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v2 1/2] dts: rewrite README
Date: Tue,  3 Jun 2025 13:28:26 -0400
Message-ID: <20250603172827.458725-1-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527153734.368235-2-dmarx@iol.unh.edu>
References: <20250527153734.368235-2-dmarx@iol.unh.edu>
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

Remove unnecessary information from README.md,
and add new sections to clarify the purpose/use
of DTS along with clear setup instructions.

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
Reviewed-by: Patrick Robb <probb@iol.unh.edu>
Reviewed-by: Paul Szczepanek <paul.szczepanek@arm.com>
---
 dts/README.md | 115 +++++++++++++++++++++++++-------------------------
 1 file changed, 57 insertions(+), 58 deletions(-)

diff --git a/dts/README.md b/dts/README.md
index 2b3a7f89c5..224a7aa20b 100644
--- a/dts/README.md
+++ b/dts/README.md
@@ -1,67 +1,66 @@
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
+1. 2 links topology: Represents a topology in which the TG node and SUT node both have two network interfaces
+which form the TG <-> SUT connection. An example of this would be a dual interface NIC which is the
+TG node connected to a dual interface NIC which is the SUT node. Interface 0 on TG <-> interface 0
+on SUT, interface 1 on TG <-> interface 1 on SUT.
+2. 1 links topology: Works, but may result in skips for testsuites which are explicitly decorated with a
+2 link requirement. Represents a topology in which the TG node and SUT node are both located on one
+network interface. An example of this would be a dual interface NIC with a connection between
+its own ports.
+
+# Simple Linux Setup
+
+1. On your TG and SUT nodes, add a dedicated user. In this example I will name the user "dts."
+2. Grant passwordless sudo to the dts user, like so:
+    2a: enter 'visudo' in your terminal
+    2b: In the visudo text editor, add:
+        dts   ALL=(ALL:ALL) NOPASSWD:ALL
+3. DTS uses ssh key auth to control the nodes. Copy your ssh keys to the TG and SUT:
+    ssh-copy-id dts@{your host}.
+
+For additional detail, please refer to [dts.rst](doc/guides/tools/dts.rst)
+
+# DTS Configuration
+
+DTS requires two yaml files to be filled out with information about your environment,
+test_run.yaml and nodes.yaml, which follow the format illustrated in the example files.
+
+1. Download Docker on the SUT, and Scapy on the TG.
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
@@ -76,6 +75,6 @@ will mount the SSH keys of the user currently running VSCode into the container
 The `source` on this line can be altered to mount any SSH keys
 on the local machine into the container at the correct location.
 
-### Other
+## Other
 
-Searching for '$IDE dev containers' will probably lead you in the right direction.
+Searching for '$IDE dev containers' will probably lead you in the right direction.
\ No newline at end of file
-- 
2.49.0

