Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5584C54F30
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 May 2025 15:37:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E9A7240693;
	Tue, 27 May 2025 17:37:49 +0200 (CEST)
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com
 [209.85.166.178])
 by mails.dpdk.org (Postfix) with ESMTP id F045E40669
 for <dev@dpdk.org>; Tue, 27 May 2025 17:37:48 +0200 (CEST)
Received: by mail-il1-f178.google.com with SMTP id
 e9e14a558f8ab-3dd7a95d19eso13297135ab.0
 for <dev@dpdk.org>; Tue, 27 May 2025 08:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1748360268; x=1748965068; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0cFjq1xv04SftG1/ZZ8FcUb3dyMvOcH3N3G+G+x1b4s=;
 b=ND13aKBO4hxPNeWt2y51rI3zYJT0gWrpfRS5SKOmXCF7qTNJb7TGzpMZp6Odt7DGYp
 iCMm3XmbSdn3hmLY0xJnZlKqo45KbcxohNst1UpiUBF61yxDbsX9BEYHuqoGFzTHx7dw
 GdGwPjEeAQM+vBI94t7m8KSR3+29pi5KUc3IQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748360268; x=1748965068;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0cFjq1xv04SftG1/ZZ8FcUb3dyMvOcH3N3G+G+x1b4s=;
 b=M08Vgb+axPm14XR/DRKV2H+ZfmOHKS34AEPFpwJDvoJcLMwUur6dA/uv6K/E3KDgrj
 hn9GhXR6KPKDeb2dxAeiNWLSycKU9OyLBfnORYdHkBPnkOwt5URNh29LA+OLBmxane5w
 okg8rcIiBY/lE9qdxAsstBXZGUKix46kLmKAwlIpKst4lGtn5Z504pujH5fbgc2E2JjF
 jIVnEG6Z8zvzdXrH5X0/oI/cq5AfoyNbfZjhImSvfNNE9G90d8opIUzgSA+w8KXotw08
 ml2WzoO7WyY1JpdFO7eZ/GN+nSQtP87i6+qAd7DODYQ7jYRH7MGIFKl0hYWA612+b3Vf
 5chg==
X-Gm-Message-State: AOJu0Yw6LJQ8iakSRCVl1NxHat/Xhwmn0Duae6Etns4ZfnzgGRcy92Z1
 9iW3LJuwVgxHocrx5uBRWEMi6/jiKvWtU0eXacPd35xN3FN7UfQSwmhzWtazTdeEll1BnBKw/6U
 SxgC4
X-Gm-Gg: ASbGncs1raN5AlaCWyGrf61qJtt8EG9yq3o5HpTj8DEn9ENxZh+jFax2r2CtQkh+ROf
 wpb0TRjO27gpXgpk+fhzn1wLe/z7FEgbEr9+B4AiHqUd21OQj7cr9+2GeFlDQSCIvNnHef3B3fi
 43zBoL0tm6MFtWB+oyMW7LC/QlCTmIK9YwhSnWz2LoYT92Aq86RcvDlX8/Zs9aQhI1C0LDxRCue
 P9NPmpdeMIlZ9QpuU3WdjhdBw7/v+za2DBAku0urndrCSpy4Vm9Lpakw7yoWThPWgTb9tOtq+l0
 /+1osAnTRh1DfvVGFovt23+mduuhuXanw1amBKOzvSXA2VEjVg8Pxw==
X-Google-Smtp-Source: AGHT+IHmXv9o2fyXtT6523L/XcHBzZrI/UWR0ygHOg6UvlXx9neRJhXFQuLKg22ZTmS2hVCqXfV68Q==
X-Received: by 2002:a05:620a:400f:b0:7c5:5fa0:4617 with SMTP id
 af79cd13be357-7ceecc25ef5mr2073446885a.40.1748360257236; 
 Tue, 27 May 2025 08:37:37 -0700 (PDT)
Received: from fedora.hsd1.nh.comcast.net ([2606:4100:3880:1257::100a])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cd467bd91asm1753910685a.7.2025.05.27.08.37.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 08:37:36 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v1 1/3] dts: rewrite README
Date: Tue, 27 May 2025 11:37:32 -0400
Message-ID: <20250527153734.368235-1-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.49.0
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

Remove unnecessary information from README.md, and add new sections to clarify
the purpose/use of DTS along with clear setup instructions.

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
---
 dts/README.md | 104 +++++++++++++++++++-------------------------------
 1 file changed, 39 insertions(+), 65 deletions(-)

diff --git a/dts/README.md b/dts/README.md
index 2b3a7f89c5..879cf65abc 100644
--- a/dts/README.md
+++ b/dts/README.md
@@ -1,81 +1,55 @@
-# DTS Environment
+# Description
 
-The execution and development environments for DTS are the same,
-a [Docker](https://docs.docker.com/) container defined by our [Dockerfile](./Dockerfile).
-Using a container for the development environment helps with a few things.
+DTS is a testing framework and set of testsuites for end to end testing of DPDK and DPDK 
+enabled hardware. Unlike the DPDK unit test application, DTS is intended to be used to 
+evaluate real DPDK workloads run over supported hardware. For instance, DTS will control
+a traffic generator node which will send packets to a system under test node which is 
+running a DPDK application, and evaluate those results.
 
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
+# Supported Test Node Topologies
 
-## Tips for setting up a development environment
+DTS is a python application which will control a traffic generator node (TG) and system 
+under test node (SUT). The nodes represent a DPDK device (usually a NIC) located on a 
+host. The devices/NICs can be located on two separate servers, or on the same server. If you use
+the same server for both NICs, install them on separate NUMA domains if possible (this is ideal
+for performance testing.)
 
-### Getting a docker shell
+1. 2 link: Represents a topology in which the TG node and SUT node both have two network interfaces
+which form the TG <-> SUT connection. An example of this would be a dual interface NIC which is the
+TG node connected to a dual interface NIC which is the SUT node. Interface 0 on TG <-> interface 0 
+on SUT, interface 1 on TG <-> interface 1 on SUT.
+2. 1 link: Works, but may result in skips for testsuites which are explicitly decorated with a
+2 link requirement. Represents a topology in which the TG node and SUT node are both located on one
+network interface. An example of this would be a dual interface NIC with a connection between
+its own ports.
 
-These commands will give you a bash shell inside the container
-with all the Python dependencies installed.
-This will place you inside a Python virtual environment.
-DTS is mounted via a volume, which is essentially a symlink from the host to the container.
-This enables you to edit and run inside the container
-and then delete the container when you are done, keeping your work.
-It is also strongly recommended that you mount your SSH keys into the container
-to allow you to connect to hosts without specifying a password.
+# Simple linux setup
 
-#### Start docker container with SSH keys
+1. On your TG and SUT nodes, add a dedicated user. In this example I will name the user "dts."
+2. Grant passwordless sudo to the dts user, like so:
+    2a: enter 'visudo' in your terminal
+    2b: In the visudo text editor, add:
+        dts   ALL=(ALL:ALL) NOPASSWD:ALL
+3. DTS uses ssh key auth to control the nodes. Copy your ssh keys to the TG and SUT:
+    ssh-copy-id dts@{your host}.
 
-```shell
-docker build --target dev -t dpdk-dts .
-docker run -v $(pwd)/..:/dpdk -v /home/dtsuser/.ssh:/root/.ssh:ro -it dpdk-dts bash
-$ poetry install
-$ poetry shell
-```
+For additional detail, please refer to [dts.rst](doc/guides/tools/dts.rst)
+
+# DTS Configuration
 
-#### Start docker container without SSH keys
+DTS requires two yaml files to be filled out with information about your environment,
+test_run.yaml and nodes.yaml, which follow the format illustrated in the example files.
 
 ```shell
 docker build --target dev -t dpdk-dts .
-docker run -v $(pwd)/..:/dpdk -it dpdk-dts bash
+docker run -v $(pwd)/..:/dpdk -v /home/dtsuser/.ssh:/root/.ssh:ro -it dpdk-dts bash
 $ poetry install
-$ poetry shell
+$ poetry run ./main.py
 ```
 
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
-
-### Visual Studio Code
-
-VSCode has first-class support for developing with containers.
-You may need to run the non-Docker setup commands in the integrated terminal.
-DTS contains a .devcontainer config,
-so if you open the folder in VSCode it should prompt you to use the dev container
-assuming you have the plugin installed.
-Please refer to
-[VS Development Containers Docs](https://code.visualstudio.com/docs/remote/containers)
-to set it all up.
-Additionally, there is a line in `.devcontainer/devcontainer.json` that, when included,
-will mount the SSH keys of the user currently running VSCode into the container for you.
-The `source` on this line can be altered to mount any SSH keys
-on the local machine into the container at the correct location.
+These commands will give you a bash shell inside a docker container
+with all DTS Python dependencies installed.
 
-### Other
+## Other
 
-Searching for '$IDE dev containers' will probably lead you in the right direction.
+Searching for '$IDE dev containers' will probably lead you in the right direction.
\ No newline at end of file
-- 
2.49.0

