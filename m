Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0230FD4F16
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 18:44:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 634AB4067E;
	Tue, 10 Mar 2026 19:44:54 +0100 (CET)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com
 [209.85.219.47]) by mails.dpdk.org (Postfix) with ESMTP id 9C76A40662
 for <dev@dpdk.org>; Tue, 10 Mar 2026 19:44:53 +0100 (CET)
Received: by mail-qv1-f47.google.com with SMTP id
 6a1803df08f44-899eabc5292so99329346d6.0
 for <dev@dpdk.org>; Tue, 10 Mar 2026 11:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1773168293; x=1773773093; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6Yp/vDAanmep1UtYUlviz56QRV9aZhEJpfJNvcSX0lk=;
 b=UMXvswIhNspqp3ePOtfZqMO1hwTdstTTGhGaeEbE7cTN/o/sqWqnc74XD7fNx4aWFj
 kfLXahOfMm4ZawH6mcAOb9WK20ZZ3j775DQhysnirUA3rsl2865fNpXb4nguoYge2QwH
 zO3jqmVKW2+I/v4jkdtehLaiLEHlk6D0IpgFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773168293; x=1773773093;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Yp/vDAanmep1UtYUlviz56QRV9aZhEJpfJNvcSX0lk=;
 b=dixf6zcvJxtma9tkcWcg9dAg/baO5Esq+iW2zix+xru7kGT5U08lpzDpTMBcz3A8P4
 7PSnnOmiN6NrysOsdAlw+MERfkguvZV3K1DeyZEhf/aMzLbX+Q8SXmqtzjD35+DQ8QMd
 L2JgbRQyU0XX1xikLpmG5PEjnqzk3B8ngBbZfxVZHoJgs8JH+lm/32Z11DzoZLZqclEq
 GfvqC3ZpJOxrRGTQwyIPHJhxS1okOa8y3wkGh3YdXbYnH2BEVYS5mY1vifanPXx67n3D
 cLhL8xQgvHNb7aDukoTdIQcyla6ap0+3ui/naKAkMTOGQTmop0fOdzSUlOXDdHvv8TOg
 +ISA==
X-Gm-Message-State: AOJu0Ywyyf4u3VR+7q0vYFhcd5DsoMZVevep5gzGp6yF8+0WysYLmwWA
 OLoO64611K2ZGaJ81dGcXsIqDgFIfHYNi6sg5jcVJGHwZbKisw72u0nTX/eNo3bRyrE=
X-Gm-Gg: ATEYQzzgvcBhqN2WlyXCQ1a/gdqaFGQzDnzJ7C9WITtT2S/J1OHLoniN90NmTrp8lJt
 QJZAx88I2QIi7yQnqSUBxe7GGLuOidbBrhte9LuSglXqE0FGtwSgAhtYtYmCnT+FU7JNzkAcet0
 JIm409fYpgag3BRpTbxy6u8FIsEGzE+xD3HcgtdHAhDrzpcR9iDl2WUo9oLjHhcl5C+Qvv5OyIy
 gR92b+xDupHrJeQVHJF7sFeFncfRWLkzYej7ShdIiE5BIzgUOs6ITD+D8omdaPEryl3p584c5ux
 sgP/7iTPPDHAc5T+Ff/uOaVU+01cXtrUYCDImCuDSto6I2gPDOLh/0omTVO66DfR0gUWjF8+dQd
 EiGVtJK4O4qUDsx47XLIuweudRMYHSddywLIZZwfQEx8WvMddmhQehhwNlUeJ+VdFOCMtmN7Uy1
 PE+GoAy5d9iw0jAVFhHnefnaPWz3QogbtFdOe0tKM30O7YX64QH8P8MDkkkp32KA==
X-Received: by 2002:a05:6214:4105:b0:899:fd64:1b72 with SMTP id
 6a1803df08f44-89a30ace8e2mr244237486d6.41.1773168292697; 
 Tue, 10 Mar 2026 11:44:52 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1220:a136:b4d:e75:44c4])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a57c2c482sm24070926d6.42.2026.03.10.11.44.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 11:44:52 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: probb@iol.unh.edu
Cc: dev@dpdk.org, luca.vizzarro@arm.com, dmarx@iol.unh.edu,
 Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v1] dts: add default values for queue info
Date: Tue, 10 Mar 2026 14:44:15 -0400
Message-ID: <20260310184416.216482-1-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
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

Currently, an error is raised on some environments when running the
queue start stop test suite due to fields failing to populate with no
default. These fields are not accessed by the test suite and this commit
handles this case gracefully by setting the default to None instead of
crashing.

Bugzilla ID: 1901

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
---
 dts/api/testpmd/__init__.py |  8 +++++++-
 dts/api/testpmd/types.py    | 28 +++++++++++++++++++++-------
 2 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/dts/api/testpmd/__init__.py b/dts/api/testpmd/__init__.py
index 703cae487e..a9724df7e4 100644
--- a/dts/api/testpmd/__init__.py
+++ b/dts/api/testpmd/__init__.py
@@ -1293,9 +1293,15 @@ def start_port_queue(
                 )
 
     def get_queue_ring_size(self, port_id: int, queue_id: int, is_rx_queue: bool) -> int:
-        """Returns the current size of the ring on the specified queue."""
+        """Returns the current size of the ring on the specified queue.
+
+        Raises:
+            ValueError: If ring size could not be parsed from test pmd.
+        """
         command = f"show {'rxq' if is_rx_queue else 'txq'} info {port_id} {queue_id}"
         queue_info = TestPmdQueueInfo.parse(self.send_command(command))
+        if queue_info.ring_size is None:
+            raise ValueError("Ring size could not be gathered from test pmd.")
         return queue_info.ring_size
 
     def set_queue_ring_size(
diff --git a/dts/api/testpmd/types.py b/dts/api/testpmd/types.py
index 0d322aece2..a6cfcccfa0 100644
--- a/dts/api/testpmd/types.py
+++ b/dts/api/testpmd/types.py
@@ -400,19 +400,33 @@ class TestPmdQueueInfo(TextParser):
     """Dataclass representation of the common parts of the testpmd `show rxq/txq info` commands."""
 
     #:
-    prefetch_threshold: int = field(metadata=TextParser.find_int(r"prefetch threshold: (\d+)"))
+    prefetch_threshold: int | None = field(
+        default=None, metadata=TextParser.find_int(r"prefetch threshold: (\d+)")
+    )
     #:
-    host_threshold: int = field(metadata=TextParser.find_int(r"host threshold: (\d+)"))
+    host_threshold: int | None = field(
+        default=None, metadata=TextParser.find_int(r"host threshold: (\d+)")
+    )
     #:
-    writeback_threshold: int = field(metadata=TextParser.find_int(r"writeback threshold: (\d+)"))
+    writeback_threshold: int | None = field(
+        default=None, metadata=TextParser.find_int(r"writeback threshold: (\d+)")
+    )
     #:
-    free_threshold: int = field(metadata=TextParser.find_int(r"free threshold: (\d+)"))
+    free_threshold: int | None = field(
+        default=None, metadata=TextParser.find_int(r"free threshold: (\d+)")
+    )
     #:
-    deferred_start: bool = field(metadata=TextParser.find("deferred start: on"))
+    deferred_start: bool | None = field(
+        default=None, metadata=TextParser.find("deferred start: on")
+    )
     #: The number of RXD/TXDs is just the ring size of the queue.
-    ring_size: int = field(metadata=TextParser.find_int(r"Number of (?:RXDs|TXDs): (\d+)"))
+    ring_size: int | None = field(
+        default=None, metadata=TextParser.find_int(r"Number of (?:RXDs|TXDs): (\d+)")
+    )
     #:
-    is_queue_started: bool = field(metadata=TextParser.find("queue state: started"))
+    is_queue_started: bool | None = field(
+        default=None, metadata=TextParser.find("queue state: started")
+    )
     #:
     burst_mode: str | None = field(
         default=None, metadata=TextParser.find(r"Burst mode: ([^\r\n]+)")
-- 
2.50.1

