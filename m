Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082DDC02198
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Feb 2025 17:42:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 91D804068E;
	Fri, 14 Feb 2025 18:42:40 +0100 (CET)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44]) by mails.dpdk.org (Postfix) with ESMTP id 48B5040678
 for <dev@dpdk.org>; Fri, 14 Feb 2025 18:42:38 +0100 (CET)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-2fc292b3570so2190780a91.1
 for <dev@dpdk.org>; Fri, 14 Feb 2025 09:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739554957;
 x=1740159757; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1ZSsWiQ5uPzkrkjKNMZ5MTGHBa4OD5e6tsHCkBx2NDY=;
 b=Q3WQrv4zFYIcKOVpvk2dh4P4S0Ep5y33wLGey7F1yh0kg/WuOtpYewBfD/PwYvFT+f
 5Vn4935duRVMS1Msjd2gIg93gjmtjIvAbTjgtQ1HPzQoz90Tc9wgtnNUT6l776DsrJL8
 nZprwfpMHyE0tMT2OCsdratb4PA7fngSalZ2gXzjivAKY1/om5M+fU/SiIU1RVWP0Zwb
 Zh6Leh0qtpNKBz3ONB8nxOq/988CO/ybuTKonuSr2fkaWVYhH835IjE3T2pE8R4iVCFT
 OwoOKxql5lU2wfp1KghA7wYFu+qKQKDnB7sIsjflNvGKSJ63ynE4oHkmnEKIWMLp4xoe
 CR7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739554957; x=1740159757;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1ZSsWiQ5uPzkrkjKNMZ5MTGHBa4OD5e6tsHCkBx2NDY=;
 b=tz1fMvD9DpalgyKmbaXvQXbi1MI0XTzOj4wr8Q6k/B9YnlHI/z8YbW8/cpCtWgzn80
 Zk2cVp0QVl5WdppUmkJ4qL1NauaDFdLFCPOIJo1ncel641R+STYx/wsOgI0R3jAPVjwM
 c0mOzlQtBt/l7Vc1k9VFjb9zd3Eda6AXM9MCcI0jt8gREtHWHdz+HDixQ/we9nzcu33r
 NdY1PzbHnJP6/QGdCaqJ3EEa+PiPbh0C56GEbLoCxMkEZqxmmkVwwMLq16Af+UzdLhLL
 EUR+0q5DjnNS0iBJiEn8+uX0eY5IE/PdW8eAJqedCb+3hH9D7+dPbw5J9ehBpR7UyQJw
 IbBg==
X-Gm-Message-State: AOJu0YydBhj96c7k3Jpj6uQrReTuae+RhiSgYD4bk+meJvM/NnfIU04c
 91y1PLofO0okU2Tb4CdcFRs7Oe0xdR0vhWkkfMqb+dicTYe5xsc7l1tPXfXJ9nnBuigDeERoSUl
 sk1o=
X-Gm-Gg: ASbGncs3oodMAXC5T22dMzMr9GRor3QRBL/AVpgIlzsZg8KgXy7e4ACvUtv0SawGKvs
 BKEAM48XjKUnJETDhppEr5BX+2877MO9f7/2Wh8v8YYkRk/7H2WasjQDLgbNd+IalkVS7pZfsL+
 L1nEiLskg6g7Kf4j9jOik3BdoiSWZCqv6oV4Auqe25OgDryChfTg3XNrvs/XtBzCxdti+zllmLJ
 aryIHG3aHCnhqt44BO5QaXCBlbUa2OmSMa32JQXbHGlOf1uA9WDlhXpxi0RMySb9tS2E4ZlkDHP
 Zs+BvaP/UsbkDehmMAZFDGrXhkvFJSPc6sWbwzBmJXYpn/9swbdFXRH8ydYGF+KseSsK
X-Google-Smtp-Source: AGHT+IFoQIpbHMxl+CoqmqSHknhHFgXkrQRLgo8N/7bQURTrTFblZ9qVG49b3mCV840TUTLwEMHMnQ==
X-Received: by 2002:a17:90b:4f85:b0:2f8:4a3f:dd2d with SMTP id
 98e67ed59e1d1-2fc0e6ad581mr12895019a91.15.1739554957504; 
 Fri, 14 Feb 2025 09:42:37 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fbf98f48eesm5449852a91.22.2025.02.14.09.42.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 09:42:37 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Jeroen de Borst <jeroendb@google.com>, Rushil Gupta <rushilg@google.com>,
 Joshua Washington <joshwash@google.com>, Long Li <longli@microsoft.com>,
 Wei Hu <weh@microsoft.com>, Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>,
 Jochen Behrens <jochen.behrens@broadcom.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 John McNamara <john.mcnamara@intel.com>, Yong Wang <wang.yong19@zte.com.cn>
Subject: [PATCH v2 2/6] doc: fix feature flags for queue start/stop
Date: Fri, 14 Feb 2025 09:38:55 -0800
Message-ID: <20250214174224.79142-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250214174224.79142-1-stephen@networkplumber.org>
References: <20241213214929.817688-1-stephen@networkplumber.org>
 <20250214174224.79142-1-stephen@networkplumber.org>
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

Several drivers have mismatch between the ethdev ops for queue
start/stop and the documentation. The gve driver does implement
queue start/stop support. The mana, netvsc, virtio and vmxnet3
drivers do not implement the rx_queue_start callback.

Fixes: 410333da8b5f ("net/mana: start/stop Tx queues")
Fixes: beff6d8e8e2e ("net/netvsc: add documentation")
Fixes: 9db3f52126fb ("doc: generate NIC overview table from ini files")
Fixes: 24595041937e ("net/vmxnet3: update feature doc")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/nics/features.rst         | 1 +
 doc/guides/nics/features/gve.ini     | 1 +
 doc/guides/nics/features/mana.ini    | 1 -
 doc/guides/nics/features/netvsc.ini  | 1 -
 doc/guides/nics/features/virtio.ini  | 1 -
 doc/guides/nics/features/vmxnet3.ini | 1 -
 6 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/doc/guides/nics/features.rst b/doc/guides/nics/features.rst
index 8bd448139e..a075c057ec 100644
--- a/doc/guides/nics/features.rst
+++ b/doc/guides/nics/features.rst
@@ -149,6 +149,7 @@ Queue start/stop
 ----------------
 
 Supports starting/stopping a specific Rx/Tx queue of a port.
+This is required for use deferred start configuration option.
 
 * **[implements] eth_dev_ops**: ``rx_queue_start``, ``rx_queue_stop``, ``tx_queue_start``,
   ``tx_queue_stop``.
diff --git a/doc/guides/nics/features/gve.ini b/doc/guides/nics/features/gve.ini
index 8dfa229bb0..f18b829eda 100644
--- a/doc/guides/nics/features/gve.ini
+++ b/doc/guides/nics/features/gve.ini
@@ -6,6 +6,7 @@
 [Features]
 Speed capabilities   = Y
 Link status          = Y
+Queue start/stop     = Y
 MTU update           = Y
 TSO                  = Y
 RSS hash             = Y
diff --git a/doc/guides/nics/features/mana.ini b/doc/guides/nics/features/mana.ini
index 42fd3327d2..db555ffe27 100644
--- a/doc/guides/nics/features/mana.ini
+++ b/doc/guides/nics/features/mana.ini
@@ -8,7 +8,6 @@ Speed capabilities   = P
 Link status          = P
 Removal event        = Y
 Rx interrupt         = Y
-Queue start/stop     = Y
 RSS hash             = Y
 L3 checksum offload  = Y
 L4 checksum offload  = Y
diff --git a/doc/guides/nics/features/netvsc.ini b/doc/guides/nics/features/netvsc.ini
index de8c698184..32df77a03e 100644
--- a/doc/guides/nics/features/netvsc.ini
+++ b/doc/guides/nics/features/netvsc.ini
@@ -7,7 +7,6 @@
 Speed capabilities   = P
 Link status          = Y
 Free Tx mbuf on demand = Y
-Queue start/stop     = Y
 Scattered Rx         = Y
 Promiscuous mode     = Y
 Allmulticast mode    = Y
diff --git a/doc/guides/nics/features/virtio.ini b/doc/guides/nics/features/virtio.ini
index a5eab4932f..f0a1a564f9 100644
--- a/doc/guides/nics/features/virtio.ini
+++ b/doc/guides/nics/features/virtio.ini
@@ -8,7 +8,6 @@ Speed capabilities   = P
 Link status          = Y
 Link status event    = Y
 Rx interrupt         = Y
-Queue start/stop     = Y
 Scattered Rx         = P
 Promiscuous mode     = Y
 Allmulticast mode    = Y
diff --git a/doc/guides/nics/features/vmxnet3.ini b/doc/guides/nics/features/vmxnet3.ini
index 971695fc4a..749887d642 100644
--- a/doc/guides/nics/features/vmxnet3.ini
+++ b/doc/guides/nics/features/vmxnet3.ini
@@ -7,7 +7,6 @@
 Speed capabilities   = P
 Link status          = Y
 Link status event    = Y
-Queue start/stop     = Y
 MTU update           = Y
 LRO                  = Y
 TSO                  = Y
-- 
2.47.2

