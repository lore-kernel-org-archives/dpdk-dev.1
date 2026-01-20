Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD2F7D262AB
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 23:16:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5533241132;
	Wed, 21 Jan 2026 00:16:45 +0100 (CET)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47]) by mails.dpdk.org (Postfix) with ESMTP id 4AA4B4111C
 for <dev@dpdk.org>; Wed, 21 Jan 2026 00:16:44 +0100 (CET)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4801bbbdb4aso2056155e9.1
 for <dev@dpdk.org>; Tue, 20 Jan 2026 15:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dyna-nic.com; s=google; t=1768951003; x=1769555803; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D6umPjiCqoc8tqD5Gdz/Mi7MMub9Usd9nrS4h7h6XAk=;
 b=XrHCcSfnUG85PG+NBwivRbyFUlGzHd4gpL2FNkdEsUF7kkYB6wI/k18HYKS4FQbj4I
 W6xKr8NeEODuICRQMVzpPLcElaEEHiWbyXXStWlZUMH3VgbZdcxG4MmEZzZPb4P0Or2u
 dQFTKIXJHJq862u8mhzvsKI1lgEjNXgN9lyATRiA6QI9fcgJmwIdPFj8L5nxGqQh8kwS
 CbdvPLLjDJFk84g+exas0UnVrrr8dTd1O79igM99/egqzZCH9eifk22xYsRel3lfoKTw
 1AApXPKZQk9vesukbQKGuocgeZ/u3WFntngeILVnxlEQWtINenAY/Kc97IJ1cg+Ygax1
 L7+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768951004; x=1769555804;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=D6umPjiCqoc8tqD5Gdz/Mi7MMub9Usd9nrS4h7h6XAk=;
 b=XKGf9rFO95sGYpqZAlorVJRf8aRG9E+zb9+L0Pj2hFPW4KAqcclzw99dgp+WiwJ9Fz
 il5ztJSs8CwNh6VGHinHYXMiwOAh3HH12BZWP7pRcAVqXNjtg52Y2jCG49weEU9lgEQR
 Dc0UTpEGjJ7puzGEv5T9DFYL3O7F5om/mautPxRLlwECzpomTr73YQeIpF3GjkDACWXe
 3zYSIHzXX1Xjno5wGkFHF59jG2qS7YbJEzNDJnLQr5QNplrdNq8NRF9s/BWCq2YlwR73
 oS8f2bWbKMX56+4HDuSYnsOUsxBdSSJ5REKsQGlwoKjkORycDJPAo+RP8wIzpjdCfJ04
 M0zA==
X-Gm-Message-State: AOJu0YxsvwIISWZySVJ2/2KniKurTlj/dvbdvv9M8cQTqkGmE3mPYGQi
 Lg6V6oEcVLleAQFu1//61jZMaPbJzYpJl44W3k1GwJ6Gvbbn8kjVxzMjOZuFqZsbhjBCXlSbv0r
 98Baq
X-Gm-Gg: AZuq6aJeF244cy5hCRIk2NlbYCGtEaKgNrT28GIgDLlzF29VgR89zG1idl4f2lipzed
 WoYQxMgZsQ6Io4eGilxcLnbQPENG0SNcrT2EcKYpqJBDpn1oeC8YhOrS3J+17lVtZYChMZ+RBRm
 byVrvCBUvJ7JGqD3+HKPuNJLBtBfTEwGWrI1Fp6NaD5LIt7WLqcxHux1758R4T8G3vHgGlLHeVH
 Yi1pyOAzXAAEsvQV5gslu/sCLuUdlPt+7jRIcprvLaletM6gbj4je/k/Kn41q5l0x0ayqSXAJAP
 5iWj9IQh869SsScGUGQAeo7MiENsIb/WCcafQdOW6XCp2r5iIVqFYbxtmxi8orb/trJpKGrtpFv
 2lJrD0JsN4mTNvaERWc21XTNHHG6AsnYa1Jolif/ymNhWPZnzO/BpbE/Q2lLWF+LPGWVLD8rM7R
 x2G4aucBF5MulBWbe/afa+Lr1W6wh8qG0H8pnNJibeSZOiAA==
X-Received: by 2002:a05:6000:40df:b0:432:da7c:5750 with SMTP id
 ffacd0b85a97d-435695651aamr20880746f8f.20.1768951003645; 
 Tue, 20 Jan 2026 15:16:43 -0800 (PST)
Received: from claret.liberouter.org (rt-tmc-kou.liberouter.org.
 [195.113.172.126]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43595e0a705sm3903968f8f.14.2026.01.20.15.16.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 15:16:43 -0800 (PST)
From: Lukas Sismis <sismis@dyna-nic.com>
To: dev@dpdk.org
Cc: dmarx@iol.unh.edu, probb@iol.unh.edu, thomas@monjalon.net,
 Lukas Sismis <sismis@dyna-nic.com>
Subject: [PATCH v2 1/1] dts: fix invalid f-string syntax in testpmd API
Date: Wed, 21 Jan 2026 00:16:38 +0100
Message-ID: <20260120231638.194471-2-sismis@dyna-nic.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260120231638.194471-1-sismis@dyna-nic.com>
References: <20260120231638.194471-1-sismis@dyna-nic.com>
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

Fix f-string syntax errors where double quotes were nested inside
f-strings that also use double quotes as delimiters.

Signed-off-by: Lukas Sismis <sismis@dyna-nic.com>
---
 dts/api/testpmd/__init__.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/dts/api/testpmd/__init__.py b/dts/api/testpmd/__init__.py
index a20dedc25a..703cae487e 100644
--- a/dts/api/testpmd/__init__.py
+++ b/dts/api/testpmd/__init__.py
@@ -227,7 +227,7 @@ def start_tx_first(self, burst_num: int, verify: bool = True) -> None:
             InteractiveCommandExecutionError: If `verify` is :data:`True` and forwarding fails to
                 start or ports fail to come up.
         """
-        self.send_command(f"start tx_first {burst_num if burst_num is not None else ""}")
+        self.send_command(f"start tx_first {burst_num if burst_num is not None else ''}")
         if verify:
             # If forwarding was already started, sending "start" again should tell us
             start_cmd_output = self.send_command("start")
@@ -898,11 +898,11 @@ def set_qinq_strip(self, port: int, enable: bool, verify: bool = True) -> None:
             vlan_settings = self.show_port_info(port_id=port).vlan_offload
             if enable ^ (vlan_settings is not None and VLANOffloadFlag.QINQ_STRIP in vlan_settings):
                 self._logger.debug(
-                    f"Failed to {"enable" if enable else "disable"}"
+                    f"Failed to {'enable' if enable else 'disable'}"
                     f"QinQ strip on port {port}: \n{qinq_cmd_output}"
                 )
                 raise InteractiveCommandExecutionError(
-                    f"Failed to {"enable" if enable else "disable"} QinQ strip on port {port}"
+                    f"Failed to {'enable' if enable else 'disable'} QinQ strip on port {port}"
                 )
 
     def set_mac_address(self, port: int, mac_address: str, verify: bool = True) -> None:
@@ -1535,7 +1535,7 @@ def set_port_mbuf_fast_free(
             InteractiveCommandExecutionError: If mbuf_fast_free could not be set successfully.
         """
         mbuf_output = self.send_command(
-            f"port config {port_id} tx_offload mbuf_fast_free {"on" if on else "off"}"
+            f"port config {port_id} tx_offload mbuf_fast_free {'on' if on else 'off'}"
         )
 
         if verify and "Error" in mbuf_output:
-- 
2.43.7

