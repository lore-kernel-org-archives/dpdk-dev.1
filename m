Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF78CD6E55
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 14:04:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 55F2C402BC;
	Wed,  3 Jun 2026 16:04:35 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 34D72402A9
 for <dev@dpdk.org>; Wed,  3 Jun 2026 16:04:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780495473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=n2fkJ9XpdJYJpAxy3WCNiEqEVmk1m8XrwKHFM4DJ6X8=;
 b=Ooy1q38w4YBRHlR/bCxPr+LLfkXjkFCVBSQRvbltDoRdy6/zdt09mK6WhRzOPYBBRqf5Ac
 xw5jsn6gcQmyBbCoe2vj7f3odWcDnGhEvkGSIyJaEmlCLyJCefMULuVFuX2vq6ErgJSdqg
 2xlT5E79guBgZ2GPmFjrO9f5Ktv5Hqg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-HotZQfaGMwKY6qrbQKRV6g-1; Wed,
 03 Jun 2026 10:04:32 -0400
X-MC-Unique: HotZQfaGMwKY6qrbQKRV6g-1
X-Mimecast-MFC-AGG-ID: HotZQfaGMwKY6qrbQKRV6g_1780495471
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D3F421800366; Wed,  3 Jun 2026 14:04:30 +0000 (UTC)
Received: from apanatto-thinkpadt14gen5.rmtit.csb (unknown [10.44.49.64])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7464330001A7; Wed,  3 Jun 2026 14:04:28 +0000 (UTC)
From: Andrea Panattoni <apanatto@redhat.com>
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org,
	Andrea Panattoni <apanatto@redhat.com>
Subject: [PATCH] doc: using container to build and run applications
Date: Wed,  3 Jun 2026 16:04:21 +0200
Message-ID: <20260603140421.3023794-1-apanatto@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CgqUbLTpvXxv9kao0oKNyeS35Ja9glzNjSpLgV3q7r8_1780495471
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

Add explanation about how container runtimes like podman
or docker can be used to build and run DPDK application.

Signed-off-by: Andrea Panattoni <apanatto@redhat.com>
---
 .mailmap                                   |  1 +
 doc/guides/linux_gsg/build_dpdk.rst        | 48 ++++++++++++++++++++++
 doc/guides/linux_gsg/build_sample_apps.rst | 32 +++++++++++++++
 3 files changed, 81 insertions(+)

diff --git a/.mailmap b/.mailmap
index 89ba6ffccc..48133a4b45 100644
--- a/.mailmap
+++ b/.mailmap
@@ -109,6 +109,7 @@ Andre Muezerie <andremue@linux.microsoft.com> <andremue@microsoft.com>
 Andre Richter <andre.o.richter@gmail.com>
 Andrea Arcangeli <aarcange@redhat.com>
 Andrea Grandi <andrea.grandi@intel.com>
+Andrea Panattoni <apanatto@redhat.com>
 Andrew Bailey <abailey@iol.unh.edu>
 Andrew Boyer <andrew.boyer@amd.com> <aboyer@pensando.io>
 Andrew Harvey <agh@cisco.com>
diff --git a/doc/guides/linux_gsg/build_dpdk.rst b/doc/guides/linux_gsg/build_dpdk.rst
index ed30e4a5f1..cfd10c0310 100644
--- a/doc/guides/linux_gsg/build_dpdk.rst
+++ b/doc/guides/linux_gsg/build_dpdk.rst
@@ -337,3 +337,51 @@ build system is shown below:
    dpdk = dependency('libdpdk')
    sources = files('main.c')
    executable('dpdk-app', sources, dependencies: dpdk)
+
+
+.. _building_dpdk_in_container:
+
+Building Applications in a Container
+------------------------------------
+
+DPDK can be built inside a container to provide a reproducible build environment.
+The following example uses Podman with a Fedora-based Containerfile.
+
+.. note::
+
+   These instructions also work with Docker by replacing ``podman`` with ``docker``.
+
+Create a ``Containerfile`` in the top-level DPDK source directory:
+
+.. code-block:: none
+
+   FROM fedora:latest
+
+   RUN dnf -y upgrade && dnf -y install \
+       libbsd-devel \
+       numactl-devel \
+       meson \
+       ninja-build \
+       python3-pyelftools \
+       && dnf group install -y development-tools \
+       && dnf clean all
+
+   COPY ./ /dpdk
+   WORKDIR /dpdk
+
+   RUN meson setup build -Dexamples=helloworld && ninja -C build install
+
+Build the container image from the DPDK source directory:
+
+.. code-block:: console
+
+   podman build -t dpdk-builder -f Containerfile .
+
+Once the build completes, verify that the helloworld example runs:
+
+.. code-block:: console
+
+   podman run --rm dpdk-builder /dpdk/build/examples/dpdk-helloworld
+
+See :ref:`running_sample_app_in_container` for how to run DPDK applications
+from this container image.
diff --git a/doc/guides/linux_gsg/build_sample_apps.rst b/doc/guides/linux_gsg/build_sample_apps.rst
index 5195af67ad..7154f64723 100644
--- a/doc/guides/linux_gsg/build_sample_apps.rst
+++ b/doc/guides/linux_gsg/build_sample_apps.rst
@@ -125,3 +125,35 @@ Additional sample applications are included in the DPDK examples directory.
 These sample applications may be built and run in a manner similar to that described in earlier sections in this manual.
 In addition, see the *DPDK Sample Applications User Guide* for a description of the application,
 specific instructions on compilation and execution and some explanation of the code.
+
+
+.. _running_sample_app_in_container:
+
+Running Sample Application in a Container
+-----------------------------------------
+
+A DPDK application can be run inside a container using the image built
+in :ref:`building_dpdk_in_container`.
+
+.. warning::
+
+   Hugepages must be configured on the host before running a DPDK application
+   in a container.
+   Refer to :ref:`linux_gsg_hugepages` for setup instructions.
+
+The following example runs testpmd in interactive mode with no physical NICs:
+
+.. code-block:: console
+
+   podman run -it --privileged \
+       -v /dev/hugepages:/dev/hugepages \
+       dpdk-builder \
+       ./build/app/dpdk-testpmd --no-pci -- -i
+
+.. note::
+
+   The ``--privileged`` flag grants access to hugepages and hardware resources.
+   For production deployments, consider using more fine-grained capabilities
+   and device access instead.
+
+   These instructions also work with Docker by replacing ``podman`` with ``docker``.
-- 
2.54.0

