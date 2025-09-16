Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D471DCAC599
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Sep 2025 15:02:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E89B7402E3;
	Tue, 16 Sep 2025 17:02:31 +0200 (CEST)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com
 [209.85.219.46]) by mails.dpdk.org (Postfix) with ESMTP id 88CAD402E0
 for <dev@dpdk.org>; Tue, 16 Sep 2025 17:02:30 +0200 (CEST)
Received: by mail-qv1-f46.google.com with SMTP id
 6a1803df08f44-77bec8ab89fso30131256d6.3
 for <dev@dpdk.org>; Tue, 16 Sep 2025 08:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758034950;
 x=1758639750; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ePQof9iWSk3jDNNap2Gumz6PFEume/pUbBD8WfzXrVs=;
 b=f9bN6xfaJ4e3DNZ1kqAt1u710MNgbWQM6wUYYSVDrJnDpCWwAag1eMrggPp0c8Z8yK
 lOSMbHG91ecgeNk4919UqcAJIcgIRP+PE0dYKliKotCgk/am1RDqxDUuqV5T/cj+sZsU
 Jr7PTvwxfM2HMoU6FypGljKpyN9PphAcBLEZbo/KRif7XHbKxYrec6vwwuhOUSb3TXJg
 JMso4/E5T6DM8JroHyARQ2KlMW26J/gV3/mR/HqWJjU4Efed7UxzmJhFhWzEun++RIuS
 m1Exid2yCoyw6cCWmbNXElfhITcZu4rRUbT8YdFDIfCMmuiearKIabwKS0CbqgF7nlRp
 7NWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758034950; x=1758639750;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ePQof9iWSk3jDNNap2Gumz6PFEume/pUbBD8WfzXrVs=;
 b=TYS0tcB/rSyqsM2BAj9NuAhmiNZ9lN5+NoIxauPw1Jvhz0c1N6xKHqV8RdKp/MgFHN
 jjdE82/D6DKFjDPjpVCF+62/3yTKrEgitTSFv+MwaAasoA3ouXmvRQ0hRad4p0DwtZNG
 9Tku1Y73wK8CQcA4jwP+v9el2eo64CsOAnkzEXcy3ZD7oQ6W6jc+LQ2hjrUQ38SeoxmU
 GsMb0JKDx8U7H6KDDcbDozdSuHFaDhQubDmeF5GRZ3Fx9b63sNIzFJIWIkI3wkuy5f6B
 V0tAr/NEmuLBKuYyXX571mfVuz7qUHYjK52cJSxoa7vP8XJFRzMwnMOobhKUXO3rijdS
 W3ew==
X-Gm-Message-State: AOJu0YxjQv55zQBBmuxSnNKlYM5j5IgwFjKEP8nafG3mg3PkonrNydrW
 evFRUJ8MF3bYRLaoor4xqvcOPK+DnUEpBq4MtmFWp/qwwfzU5yOGJfujOYr/ArkekQWs+IHUEN9
 UM1FE
X-Gm-Gg: ASbGncvlouY2ACUKTijuusTP/ziZSMQUGs3H/hihXrU1E8LKf7U2BHYz8rXKCG2v4lt
 +q3ml6Hx9+qsrTfc52rYlbtNTcTbTE3IMp3hsihluEPBjJ3qdlTCf9ApSzYhNsISOdlUyS74ojK
 tRGRk7d8u6ypyLD6wiTBnzHKU9lelZgx4Xyytzwre+a6h20SsY6Nxu5k+1BLMthV6o+PCi39SfH
 A3XaocX93GoeJQZ0Q1mBWf5x3R1XMfNJyFP0HJ2U8EoG7YeIiOtaEdeAzIzttM6IaRXupjnHyz8
 95/nLoSEJ9Fum+w6IKh/TTQ5Fbsc9RdcOH8mnlakZSJO+zF6Xccj0oKScrD0CfBiDfNhumce+dz
 6Z7Vc0y5ROjS4ZeCquheQa+2gIYaiZE3kjinHZyYIKdrIi+1U1Sq5vYj9wHydxdMcZZKr4mQJ
X-Google-Smtp-Source: AGHT+IGbTKfU8QiotmIFzr4aLe3DgZFW5sFZW3hCIBuZYZzweImm+49RT8zkxjsJy8dwnEZUShoHKQ==
X-Received: by 2002:a05:6214:d69:b0:78e:3196:7020 with SMTP id
 6a1803df08f44-78e31967137mr9166226d6.19.1758034948999; 
 Tue, 16 Sep 2025 08:02:28 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-763bee7c80dsm94324306d6.52.2025.09.16.08.02.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 08:02:28 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 0/4] Cuckoo hash optimization for small sizes
Date: Tue, 16 Sep 2025 08:00:43 -0700
Message-ID: <20250916150219.104936-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <0250818233102.180207-1-stephen@networkplumber.org>
References: <0250818233102.180207-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Recent discussion around handling small keys motivated furthur
examination of the compare logic.

v4 - add test for more sizes, and a few more special case sizes.

Stephen Hemminger (4):
  hash: move table of hash compare functions out of header
  hash: use static_assert
  hash: reduce architecture special cases
  hash: add support for common small key sizes

 app/test/test_hash.c       |   7 +-
 lib/hash/rte_cmp_arm64.h   |  56 +-------
 lib/hash/rte_cmp_generic.h |  35 +++++
 lib/hash/rte_cmp_x86.h     |  60 +--------
 lib/hash/rte_cuckoo_hash.c | 256 +++++++++++++++++++++++++++++++++++--
 lib/hash/rte_cuckoo_hash.h |  84 +-----------
 6 files changed, 295 insertions(+), 203 deletions(-)
 create mode 100644 lib/hash/rte_cmp_generic.h

-- 
2.47.3

