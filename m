Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E02606A31C
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Nov 2026 17:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uLfZCU8q
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 27F2A402BF;
	Tue, 17 Nov 2026 18:57:25 +0100 (CET)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com
 [209.85.219.54])
 by mails.dpdk.org (Postfix) with ESMTPS id 7B08D402A4
 for <dev@dpdk.org>; Tue, 17 Nov 2026 18:57:23 +0100 (CET)
Received: by mail-qv1-f54.google.com with SMTP id
 6a1803df08f44-91e8a05ec5aso71625916d6.1
 for <dev@dpdk.org>; Tue, 17 Nov 2026 09:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794938242; x=1795543042; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KZzndO1H66eXDPRCss/noX76dfH/yeAQxdvdHeNe3Fk=;
 b=uLfZCU8q4NgZa2yan3R0Pep6c/TLp+l2eRvChOKiuATp8AfiJxTQMHBBM65ka8JetI
 2IWKlCfhLEyz7SOg1IYnfCGJK9THdNsovqedQ/xUwtl2ynFTxXVXG5yqbxgYCpy8I1+u
 JOWIhoKuz15tBXzvUnSJoTiBNhOsp+UuAyMOMEbqoCfdtJrub3tQlCjW/ahIuSUTjy5+
 Md31U8VA20t2vWXbmMdzmEnqVIo6kKaRX7bKaAKGa08m+h5LkCcHOypYSz/68M2/jOhl
 QO1yQhlCNLKRFaedlmzyL8NV+BMR6PI8WmNwCu9Fy4YjNWyQuCkW5hmPuDdAVvkcmCrL
 xxJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794938242; x=1795543042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KZzndO1H66eXDPRCss/noX76dfH/yeAQxdvdHeNe3Fk=;
 b=FjH6y0gZ46U5qkshA1Uest/gzJ4B2bFsDvGEkfzPY58zvRubW8sw7xONigdaKKBKyz
 wnSIUPoo1G8/ukF14YZceozFYkTwqn8SDeFxTjZo4IIzYXxOIYkExM1LrDPs8ZRjFKxQ
 jkMqTDShzEd+Ni6J3b29jMVan3UnJsnVaW3KPlMNxt7tv++xn4WsQ+elSu2HGJ2/QSJ3
 FFyn3vtMOxLXZOdNwD4LDRjhJBnFFmUlht4R+hX4xOOOY9Wfz4Oo1eV4UXNPb3Pd5Qe+
 EbFpJjF01O4R6Y3ujxyf6r8O+QC3jW5fy53S8JK2nJy+6cPq+ecndJShGOiSu5uABW8G
 osQw==
X-Gm-Message-State: APuU4Z86e0resWNoWBye60iFOsIAyrkXHreHnQAQba9WYxJjTYEGDkjO
 ngaoU0f9WDPGVrSVrFf9T9Ao+S7lRCkrK0C/iiMdf1p6Cq3aIOkGM47jJ0vk5GxG
X-Gm-Gg: AZFdTZc6mXlND6NOgiq+9ziT2JEqyCVKBY05L3q98Dhvm6al5Abts2PZXBetYGzsKsM
 A+TuKd/OoxTc6nyDLUuBbUqLidxTUOm+coeqAMYm7VHUP/gt5cFhdpTlJC6jTapGAy3aUhFC3Eo
 m9zHNBvodG9gzR5iWa50nLU3xCRN4XCwyx0pEkOExfOQIiS7g5dHdijYOevbdAYZuHIAAIIOddG
 h1DF5QJN/ReJ5D5i/WVqI3wxoagrcxT93CehRKXYSA0ozm7AWyPHUvdp6EJyO80uJBqx4OiJWcR
 FyqN/5JvZQe69LnzrnCC9lbGDty+/w4SNOc9JF2quFkfueqZOxcda8MkbNy4aX+LXRKCww5qvSR
 wbuMxv575/5uVMVJiq/qGei+GK9ir8qw2YwVL5vUFaqrzUL9vKiVUKfDDH72rcajc/G6gq9BCz/
 16+1dgiEsEQRz5RKEunyNNZmot7wCRdLLDWvCgliaGx0I5dxKWbqMEkvMqJZXNLV+F2luGSLuaW
 P+yF2ourstkg0LZt4QWoQjniKZDjPZBzYn9uuQOkt73zzwud00o5fqA6xNbAFvc/CqzFyDc+Sw4
 EleTW2ZFzbGH76JzyDimpPK0j/GXQfREF2/tYGE9tEwsyRHjEdCjkd2tNGN/kSTEhzrO2DgoOHc
 BU9G0vbeg87IHenz6AnCLokkcl0Pak8eBWq8vPZPpieHs6+s3tPeOI+4zQ9x0iRkld3TGgAE6QA
 ==
X-Received: by 2002:a05:6214:d87:b0:921:19a:e11e with SMTP id
 6a1803df08f44-921019ae381mr41512876d6.25.1794938242259; 
 Tue, 17 Nov 2026 09:57:22 -0800 (PST)
Received: from pravin-HP-Z840 (ool-944c29f7.dyn.optonline.net. [148.76.41.247])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-921148c261bsm327426d6.0.2026.11.17.09.57.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 09:57:21 -0800 (PST)
From: Pravin Pathak <pravinpathakdev@gmail.com>
To: dev@dpdk.org
Cc: jerinj@marvell.com, bruce.richardson@intel.com, thomas@monjalon.net,
 david.marchand@redhat.com, nipun.gupta@amd.com, chenbox@nvidia.com,
 tirthendu.sarkar@intel.com, mattias.ronnblom@ericsson.com,
 stephen@networkplumber.org, Pravin Pathak <pravin.pathak.dev@gmail.com>
Subject: [PATCH v2 0/8] event/slb: introducing software load balancer eventdev
 PMD
Date: Tue, 17 Nov 2026 12:57:00 -0500
Message-ID: <20261117175709.2346400-1-pravinpathakdev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107013011.2443138-9-pravinpathakdev@gmail.com>
References: <20261107013011.2443138-9-pravinpathakdev@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Pravin Pathak <pravin.pathak.dev@gmail.com>

This series introduces the Software Load Balancer (SLB) Eventdev PMD
(`event_slb`) supporting parallel, atomic and ordered queues. It is 
a distributed software scheduler that scales well.

v2:
	- Fixed ARM64 build issue
	- Fixed reorder queue early credit release
	- Made all internal functions static
	- Fixed all AI review feedback

Pravin Pathak (8):
  event/slb: introduce software load balancer PMD
  event/slb: add support for ordered queues
  event/slb: add support for atomic queues
  event/slb: add dynamic flow migration for atomic queues
  event/slb: add extended statistics and diagnostics
  event/slb: add self-test and documentation
  event/slb: fine tuning and fixes
  event/slb: address ARM64 build and all code reviews

 MAINTAINERS                            |    6 +
 app/test/test_eventdev.c               |    7 +
 doc/guides/eventdevs/features/slb.ini  |   25 +
 doc/guides/eventdevs/index.rst         |    1 +
 doc/guides/eventdevs/slb.rst           |   69 ++
 doc/guides/rel_notes/release_26_11.rst |    7 +
 drivers/event/meson.build              |    1 +
 drivers/event/slb/meson.build          |   21 +
 drivers/event/slb/slb_evdev.c          |  931 +++++++++++++++++
 drivers/event/slb/slb_evdev.h          |  252 +++++
 drivers/event/slb/slb_event.c          | 1294 ++++++++++++++++++++++++
 drivers/event/slb/slb_selftest.c       |  522 ++++++++++
 drivers/event/slb/slb_xstats.c         |  348 +++++++
 13 files changed, 3484 insertions(+)
 create mode 100644 doc/guides/eventdevs/features/slb.ini
 create mode 100644 doc/guides/eventdevs/slb.rst
 create mode 100644 drivers/event/slb/meson.build
 create mode 100644 drivers/event/slb/slb_evdev.c
 create mode 100644 drivers/event/slb/slb_evdev.h
 create mode 100644 drivers/event/slb/slb_event.c
 create mode 100644 drivers/event/slb/slb_selftest.c
 create mode 100644 drivers/event/slb/slb_xstats.c

-- 
2.53.0

