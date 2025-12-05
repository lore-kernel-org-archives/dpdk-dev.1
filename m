Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50FCBD3749B
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Dec 2025 20:15:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1A0D64025F;
	Fri,  5 Dec 2025 21:15:45 +0100 (CET)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id DF8A340156
 for <dev@dpdk.org>; Fri,  5 Dec 2025 21:15:42 +0100 (CET)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-47798ded6fcso20118305e9.1
 for <dev@dpdk.org>; Fri, 05 Dec 2025 12:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764965742;
 x=1765570542; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JPS7sd+QaZvrV9qH7wyKNSIUQZOrB1E/fnN513hgLzY=;
 b=uh4el/wqk7ftwqksm0hXMy2oSQn52YWuiZg6nAkSrcWT7KicNbi56ZLV7ROxyX9Usv
 9MK9RNKDoDOLn/+hRDNXaWUP3mWKPONtQ2EA/R+ZQgbpvIJgBpl3LFMVy5rO0XdSF9au
 fIxow074tqbbb/X6IX3RwrIbqFxF3zF4VNjA548Y0712QVtDmuYumQRMe1xIqauk6H/e
 upHIHZnR0p2GAJGAvRXhfp4DPRMr4r7L0jVefbmj8WtWDzEiYkJ2tFT1OcWG4eI7cA3f
 0z/dcF9qDGqUBzHckRv1C+YLPzLPM642Z5hsJJXMQYwoI6DS3zGkS028qFq0+xNXoo6c
 VFvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764965742; x=1765570542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JPS7sd+QaZvrV9qH7wyKNSIUQZOrB1E/fnN513hgLzY=;
 b=YEb/TVb+6GCiif+38wFr8kWDbXpM0hrkHoOFOYbxg9clEUfFBzWk+v9JH45aAdsIxT
 k4/Pdhiq5AUDrDfVOGOhgZb0bC+fcEwyJD7VZKEs0Zh8WgZrDA9422qxGW/UlI4d5Ftj
 tU3/I9gWK+bl2tJyLtLKx6eeffLx2nxqduhwKwYfQFgEECuyJ2Dg4/Db4HJC64dK37cN
 p3mCp1Rxas/F72UigaXt7wm/zBwMkorxwsgRwoMNZfGzYgIU0jlj2+P3LdTq96pDB4ui
 VCfAWgjKIIePH5ShO+LBtA49JGmDWGzuCRMK3++soKifXepiLYrj3dsMyNQWgpKmVxQ8
 qbLA==
X-Gm-Message-State: AOJu0YwaI1O7GryrgVTlARI+MuPXN+MDsUznECJqVaY5fgAb5gNkMcFy
 13n1mlSSDT4uQk7/a83tmkvsC6ze2Z1Kpa9a0jYLY0YHNXuSTk9ZL2ZBwcgMq4NAcD/fFqMll2I
 M7xtt
X-Gm-Gg: ASbGncsrxjiZ4sKRHTrRbajzOLrGJpmMb/xmtsTNvRGu12KqFIglTIrXIMXc3i3gwbe
 fJVnrdbsNtmAoRym10l9H4efNez7/rh7vsNqvhqz2FuABWEhm2lxdmZIr3deEijGWLPDf7BXgf8
 ZRfQfmrL/359yvw66MojTYGlEh1cPMjUJSe+Dbf4Kx3G3BM2Rv9QWNGQykXVR4CJSiu8yLMVFRA
 Z80zUgV40Ziuo3jV3u08DpZ+/t3KH6yz1XN8hAdHkvYsBUP2ljC8ehrwZv609w7t58vzfbJrGl1
 Fx53AvPGUB/Nm7McBXIz09Rnhm4gU2LU3pmJd9gkxff+RL/3aYz0iZgoz9PK1AG/P6Ge/i68yg6
 ls/T9g/DyNZ4LcFnTV5ByIMWnVT9o4HWS27MgnfkGAmgU8O8NwsxC8uO2qvmgtas/WkoBmE9Km3
 exExxVzq5D8qVwqrkYO7UJdNPzrgRUnkJ+l8JWSmM1N1A76pVvng==
X-Google-Smtp-Source: AGHT+IFWH0zKNOZQW+5PjO+MTuzoCANqRY0NnDUZ1B+Bs23ho5enG/9akQZGOYsVLcSmiqSNoJcdJQ==
X-Received: by 2002:a05:600c:8488:b0:46e:33b2:c8da with SMTP id
 5b1f17b1804b1-47939e3d210mr4442565e9.32.1764965742039; 
 Fri, 05 Dec 2025 12:15:42 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47935fce542sm45344875e9.0.2025.12.05.12.15.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Dec 2025 12:15:41 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 00/16] lib: find and fix possible string overflows
Date: Fri,  5 Dec 2025 12:11:29 -0800
Message-ID: <20251205201537.251131-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251205022948.327743-1-stephen@networkplumber.org>
References: <20251205022948.327743-1-stephen@networkplumber.org>
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

Change all the libraries to find and fix cases where a string
could overflow when formatting or using strclpy. This does provide
early indication of possible problems where the file prefix is too
long to fit in unix domain socket path, and where a hash table
is being requested that has a name too long.

v3 - allow longer hash names but warn if ring names get truncated
   - pickup some other places like latencystats and tailq
   - add release note
   - fix build on FreeBSD

Stephen Hemminger (16):
  eal: use C library to parse filesystem table
  lpm: restrict name size
  hash: add checks for hash name length
  graph: avoid overflowing comment buffer
  latencystats: add check for string overflow
  efd: handle possible name truncation
  eal: warn if thread name is truncated
  eal: avoid format overflow when handling addresses
  eal: add check for sysfs path overflow
  eal: limit maximum runtime directory and socket paths
  eal: check for hugefile path overflow
  eal: check tailq length
  eal: handle long shared library path
  ethdev: avoid possible overflow in xstat names
  vhost: check for overflow in xstat name
  lib: enable format overflow warnings

 app/test/test_hash.c                   | 21 +++++++
 doc/guides/rel_notes/release_26_03.rst |  3 +
 lib/eal/common/eal_common_config.c     |  6 +-
 lib/eal/common/eal_common_memory.c     |  2 +-
 lib/eal/common/eal_common_options.c    | 17 ++++--
 lib/eal/common/eal_common_proc.c       | 83 +++++++++++++++++---------
 lib/eal/common/eal_common_tailqs.c     |  5 ++
 lib/eal/common/eal_filesystem.h        | 17 ++++--
 lib/eal/linux/eal.c                    |  6 +-
 lib/eal/linux/eal_hugepage_info.c      | 64 +++++++-------------
 lib/eal/linux/eal_memalloc.c           | 11 +++-
 lib/eal/linux/eal_memory.c             |  9 ++-
 lib/efd/rte_efd.c                      |  7 ++-
 lib/ethdev/rte_ethdev.c                | 35 +++++++----
 lib/graph/graph_pcap.c                 |  9 ++-
 lib/hash/rte_cuckoo_hash.c             | 41 +++++++++----
 lib/hash/rte_fbk_hash.c                | 13 +++-
 lib/latencystats/rte_latencystats.c    |  9 ++-
 lib/lpm/rte_lpm.h                      |  2 +-
 lib/meson.build                        |  4 --
 lib/vhost/vhost.c                      | 14 +++--
 21 files changed, 248 insertions(+), 130 deletions(-)

-- 
2.51.0

