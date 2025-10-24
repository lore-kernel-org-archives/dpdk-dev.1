Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E527CCD1BF
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 17:47:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F141402E4;
	Fri, 24 Oct 2025 19:47:13 +0200 (CEST)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com
 [209.85.219.54]) by mails.dpdk.org (Postfix) with ESMTP id 44E2D402AC
 for <dev@dpdk.org>; Fri, 24 Oct 2025 19:47:08 +0200 (CEST)
Received: by mail-qv1-f54.google.com with SMTP id
 6a1803df08f44-87c11268b97so24278236d6.3
 for <dev@dpdk.org>; Fri, 24 Oct 2025 10:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1761328027; x=1761932827; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SNf9N+4J3eq7eJxB9KgauMPbAQ4DA+ySXjtIBA41+OA=;
 b=Q2Yv7yfGfdHClllakc/bhL+1n0I5308Kead97rXNT2l5VJaZbjvWEXKRDMN3fC2f7M
 XX9JVAYdiHPg9RU6RfeT4VL9X7rrAKBOKWwc3LNtUsPq8MX1IemWmBIfYPOLiGJca7SB
 gcE0U/p3ZWdR2hvo8JQzpbP1PXn1GvUfD3qx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761328027; x=1761932827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SNf9N+4J3eq7eJxB9KgauMPbAQ4DA+ySXjtIBA41+OA=;
 b=npTJ4u5EnRAUTn/KCG47cj9ML2k2wjFs8nIx3C7Zt9GgsEB6LPtNMbehQyggMaPoKd
 lP0HXVhxoxbG6O/ZvClMTt2jVyngc0bCPSBFF5ipDZNM2L03t/QkUo27sPp+cuD7ytgN
 MRjlvdaAd0i9jwtLnLBisD7JhyE5zujmnE+3DK2ijLqI1TwOt7BqQiRiDZecoyFrj0Lr
 wQQDLO8XP3YXGyD6tHz/YT4kuA10zAkWMcoLCsaL6V6f9zD04GcJGvu99sHjgzE+ul00
 46NqzfgpXiomnvQ5fRchV0rqOin5cW+eOPe3YyAzHgDi1LM4cu2gmSfLpmJxvqzdkM/F
 WRkw==
X-Gm-Message-State: AOJu0Yz2aCs2q4Ebmhr8BTmE6LRESaORDGdUPtdVjIbSVRHkFez15tI6
 Dx5n8mcp6My4dzsq3fJ8SS1MZe4wuyElmViuDchdzspmWFEbkPduGF75u2U4gL9C0hI=
X-Gm-Gg: ASbGncudx9x9pGPkWTftkCcsC7w8BvwmpxKokekkEgMvK5u/lEWOasJPW2plci+WrGL
 UhPAjB66DU/7qEilPOpaM47Fb2OWmR0Rg+xjyztL8Vdt5sX8ZlkgewAvZbAo3sWxZoQjQRE1f01
 sK5V2Ub45Zv9dDH7kI9xmi+O0arvAVLfPaRtkg3c0vz2VgpVb6XOASrQiDNptLUdjU+GLwnzId5
 ov5n6NSyeUXMYWXGs/T+mhj+ABgzhd3f0AqJ/aMh2SaxtRTk8yZOrXctkEaXndCXc9YByjvezKK
 kp2SFuV2UTqhjY4g+4MjWiO7ah3hdDsDJeEiSkDV8hTPzsi9NoD/Myd+952hPCAV1OQc8BdEOkr
 m3h4cCqEPy3H97aGOx50H+dgiXZwZD8TcaUwxBCcbfFYh2+D8zp3ZGsnSi6O+HDlUxrJg
X-Google-Smtp-Source: AGHT+IFJoJQI3lT0dMNDbUf2F/aF8WnaK/jHjwrVxzFbgCBrlCojg77sk78xmy4V+JhuUgrdPvrd/Q==
X-Received: by 2002:a05:6214:19c7:b0:87c:1d24:7b76 with SMTP id
 6a1803df08f44-87fb6360862mr41587176d6.12.1761328027604; 
 Fri, 24 Oct 2025 10:47:07 -0700 (PDT)
Received: from d121016.iol.unh.edu ([2606:4100:3880:1257::100a])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87f9de816a2sm40527256d6.24.2025.10.24.10.47.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Oct 2025 10:47:07 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v3 2/3] dts: add method for bringing link of interface up
Date: Fri, 24 Oct 2025 13:46:59 -0400
Message-ID: <20251024174702.600147-2-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024174702.600147-1-dmarx@iol.unh.edu>
References: <20251003192717.444490-1-dmarx@iol.unh.edu>
 <20251024174702.600147-1-dmarx@iol.unh.edu>
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

Add set_interface_link_up method to Linux Session class
for setting the link of an interface up. The existing
command most similar to this, bring_up_link, is designed
for use during topology setup within the framework,
whereas the new command is designed for use during
test suite runtime, as is needed for the virtio suite.

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
---
 dts/framework/testbed_model/linux_session.py | 4 ++++
 dts/framework/testbed_model/os_session.py    | 8 ++++++++
 2 files changed, 12 insertions(+)

diff --git a/dts/framework/testbed_model/linux_session.py b/dts/framework/testbed_model/linux_session.py
index 1f11c3e740..bfec2f3339 100644
--- a/dts/framework/testbed_model/linux_session.py
+++ b/dts/framework/testbed_model/linux_session.py
@@ -204,6 +204,10 @@ def bring_up_link(self, ports: Iterable[Port]) -> None:
 
         del self._lshw_net_info
 
+    def set_interface_link_up(self, name: str) -> None:
+        """Overrides :meth:`~.os_session.OSSession.set_interface_link_up`."""
+        self.send_command(f"ip link set dev {name} up", privileged=True, verify=True)
+
     @cached_property
     def devbind_script_path(self) -> PurePath:
         """The path to the dpdk-devbind.py script on the node.
diff --git a/dts/framework/testbed_model/os_session.py b/dts/framework/testbed_model/os_session.py
index b41bb42205..4523679dc1 100644
--- a/dts/framework/testbed_model/os_session.py
+++ b/dts/framework/testbed_model/os_session.py
@@ -590,6 +590,14 @@ def bring_up_link(self, ports: Iterable[Port]) -> None:
             ports: The ports to apply the link up command to.
         """
 
+    @abstractmethod
+    def set_interface_link_up(self, name: str) -> None:
+        """Send operating system specific command for bringing up link on specified interface.
+
+        Args:
+            name: String representing logical name of port to apply the link up command to.
+        """
+
     @abstractmethod
     def configure_port_mtu(self, mtu: int, port: Port) -> None:
         """Configure `mtu` on `port`.
-- 
2.51.0

