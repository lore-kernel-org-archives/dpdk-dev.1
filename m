Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E5AAC83F1B
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Jul 2025 17:25:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9042B4021E;
	Fri, 11 Jul 2025 19:25:41 +0200 (CEST)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com
 [209.85.160.180])
 by mails.dpdk.org (Postfix) with ESMTP id 209364013F
 for <dev@dpdk.org>; Fri, 11 Jul 2025 19:25:40 +0200 (CEST)
Received: by mail-qt1-f180.google.com with SMTP id
 d75a77b69052e-4a4312b4849so29432261cf.1
 for <dev@dpdk.org>; Fri, 11 Jul 2025 10:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1752254739; x=1752859539; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9kXm5NSjQwzcdXHhu0xOQWa0n4YoutGqzHSIcXZAmp8=;
 b=blbnfyyrPSdWbDHIGzQjqj7Q9yfmamHHHApKLA/5MRH7CgAs8NdFuFuATBVimQoKd6
 7nIKMxCfN6r2Saj6QmWxBMN3IFiQ4iB4+SLKqwhSzpDQZ6YRE6BT85JCABdWT2Cf4G5W
 mGp2DHZ1CFNqbVmP+IQb/qt3RHK26nVF8bcno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752254739; x=1752859539;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9kXm5NSjQwzcdXHhu0xOQWa0n4YoutGqzHSIcXZAmp8=;
 b=SG2DOPTItYMrNs8nYohGjymFK8LCjbe4NqAqenGpK3h7ZIFkYhRBvaGzlKdpQbXzOG
 ayXs5fYPRRKnNF8tpexrlk9locDiBzuKgtZ71F37eycL+tLgaey2EC8/q4qCcy4US0Nq
 hnJYx3GJkLogrelqoDFwSZZRqh18aL561pcytUR/k7WG7obSfge+QC6DomzFSeCqVwE+
 UX58ZaC7uIlFze6+LFwd14mu+jQawHoAv9z75xufcMflKgJXbU2JKbDBMb5Y21K2OagS
 edhaFKi9wTNjrmTw0nfqTawzcOvizUVrMXOt7MIBXBNxkR9w7jZegz9rsTSz04V3oByG
 OedQ==
X-Gm-Message-State: AOJu0YwB4AR2c4wre1bR8OPXRLk+OBuCvPuK3nSWjMVokQz2G4wMI+MQ
 Seh4pTqFBKdUp7QAXxLZH1r8bB6W6IiOaL6mP9DhpTkiklMXzuQwvdhjC8yt91hEO/o=
X-Gm-Gg: ASbGncs19IhewyXydOdoPa26dX02JRQSEKFcDKBb3/3LWawdOZLc8VhxQflRG4wqPWk
 ojQTzSpc6qwsmsp5vE1arfOzQ7a0aKWS1JZLxn5wE9sDgwnuSAtzZj7WqXCEY/LGEvsKkEaeSKD
 Dh1nvfVnaU4F3fUX2KR90PmovTglyyV9e6LRb2Zv1TM7M6Wc93aNAn3LhlwvTAfhFepS3sfAwEP
 ZZDw188Lt4FLEelTM/KLBqT2M6ckVpg2kYmcQzhwf7o8/FDd+68afuuOVG8OcBfrQuZkql+8+h8
 Z+ZNA/L58Sb7reyaDhiisLub45yxCJKdmqxnaUVWkTw32DBWK6lscj8mW9dml5hhRrNcOntulZ7
 V+jhuv4LIbzdokw==
X-Google-Smtp-Source: AGHT+IEKC/Vwo0cKB4qjSkzsGg6vOmhFv/BlgWCpfR8VUcPU+GiA90IKS1RPlkH+fvxYAmQt9Xxd8A==
X-Received: by 2002:a05:622a:1981:b0:4a4:2c92:27e3 with SMTP id
 d75a77b69052e-4a9fb94b3e9mr81114741cf.34.1752254739012; 
 Fri, 11 Jul 2025 10:25:39 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1257::100a])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a9edc65720sm23329341cf.30.2025.07.11.10.25.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 10:25:38 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v3 1/3] dts: rewrite README
Date: Fri, 11 Jul 2025 13:24:53 -0400
Message-ID: <20250711172534.540416-1-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250603172827.458725-1-dmarx@iol.unh.edu>
References: <20250603172827.458725-1-dmarx@iol.unh.edu>
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
index 2b3a7f89c5..1345f03df0 100644
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
+For additional detail, please refer to [dts.rst](../doc/guides/tools/dts.rst)
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

