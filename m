Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D82C83F1B
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Jul 2025 13:57:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 56924402DC;
	Wed, 16 Jul 2025 15:57:13 +0200 (CEST)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com
 [209.85.160.172])
 by mails.dpdk.org (Postfix) with ESMTP id E470540144
 for <dev@dpdk.org>; Wed, 16 Jul 2025 15:57:11 +0200 (CEST)
Received: by mail-qt1-f172.google.com with SMTP id
 d75a77b69052e-4ab82eb3417so18249921cf.2
 for <dev@dpdk.org>; Wed, 16 Jul 2025 06:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1752674231; x=1753279031; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dIaMxZGcETMOFZjy0UxozkpeNgp9891hByePsFBK0xY=;
 b=IzkIGKesJ4r+jJNjZFbM7GxriEj2fS9++fExOtXjq0lJEHXQC0/I6xgu+TfT4BDZ1m
 shglZlJY2lFcXNctjmtMc5AaXKlmtzizRlIAhaRhKGnSxBnaFmGFZTWGILuSuD+0tvOE
 CTQrhi8reK450KNqD0DVHzq+83Y6ZJLvrzHTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752674231; x=1753279031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dIaMxZGcETMOFZjy0UxozkpeNgp9891hByePsFBK0xY=;
 b=a0709Q3Bp5LdjgD60T79UXB5dU9gCzznID7NIgu3gDUfcOlmMjytF7pQLxrwx/ZqQX
 ig+al9JSZyuSHy96BtMNiB4Vrn8ndvb6wTpZzvtK5qIVmKy7/ZsnH/3raP8cp9oLj9s1
 Pa6QfJIRJSvRiColBdHewtk6vIS80paflbDEtH9RvLtPCcLhTGCZT1Z3AgL7Wi6Q/cOC
 zIc50UTzelRix3rsRt3k+pmb7Q4UHU+yoQ+5s2Mxokv80mkJxxZ+ULR/2pBNeN4dsPLr
 uMoLZZEagVlCtuUJ9kPs/XFudwQEJZy59oorW/otLdzO7HPHrM9IBhmSGJt0khIBk0Te
 Ty+g==
X-Gm-Message-State: AOJu0Yx+wNA2Tui2dHshSZMu3XO2euxQ//uH9o/ef6UVP9AxIYJu6EdN
 TtdXuj3xZb/rxcurX4CGa2idvT4RhZPC90Z6HKF6q/T5hB/aME+idheCo/sBORVakH0=
X-Gm-Gg: ASbGncsrzEs2atMMEvwEyv/0RBaGj+PlO/tyEa16gtSbwMeE5UraaM1MC+NV/KaaPs/
 9+SWGEDCFK/yT0zpooPh2DCwgc70oIXwGGUBzzCeStufQjL7IumY9EAAE57Ie1ueBHaV8PyYyQv
 cxAblWMwh7nD509chcm0+W7MOm321TOeORAqyK8Rlc+xFxEwRWld2mw63xFNMGsye8Wn1V+xy9N
 FFQaWta27wgG9zXbAFeF0UJg1i5BPgiRNjixaV7Q9BUDywSfb/FQWQLjrJyt/EEbK44pCjyQvXy
 x1RVocIJOfGEZBkoe5Q92zYWt8T9bRUgh/UDrjt2wgr9JZvak63Btc4RE/Y21rAf8MuKQeUXc6w
 pHiO6/eH45dFqB23MWuxYGol2/XU1yP/KBQzhiLbly8gIYD9xG6MyJJjSZeZzyUA=
X-Google-Smtp-Source: AGHT+IEPN2Ba7xspOo6hgUwgZjH9EQ9khib44ovEIXbE3wZqkizeFkbdDIUR9HK4JK0Qxs/LEDulvg==
X-Received: by 2002:a05:622a:198b:b0:4ab:6531:1288 with SMTP id
 d75a77b69052e-4ab90b4a87cmr41507711cf.35.1752674230655; 
 Wed, 16 Jul 2025 06:57:10 -0700 (PDT)
Received: from fedora.iol.unh.edu ([132.177.125.221])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ab5427925bsm46608061cf.7.2025.07.16.06.57.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 06:57:10 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v5 1/3] dts: rewrite README
Date: Wed, 16 Jul 2025 09:57:04 -0400
Message-ID: <20250716135708.49233-1-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250714171346.564267-1-dmarx@iol.unh.edu>
References: <20250714171346.564267-1-dmarx@iol.unh.edu>
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

