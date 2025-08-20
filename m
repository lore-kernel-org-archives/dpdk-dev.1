Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3099FCA0EDC
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 Aug 2025 14:06:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 06864402CC;
	Wed, 20 Aug 2025 16:06:58 +0200 (CEST)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com
 [209.85.222.178])
 by mails.dpdk.org (Postfix) with ESMTP id F001B4027D
 for <dev@dpdk.org>; Wed, 20 Aug 2025 16:06:55 +0200 (CEST)
Received: by mail-qk1-f178.google.com with SMTP id
 af79cd13be357-7e8706a6863so741754685a.3
 for <dev@dpdk.org>; Wed, 20 Aug 2025 07:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1755698815; x=1756303615; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hNNqYmm+2vddCaU7g4pO2qOZseIDzXWLw/uBxiAOMEk=;
 b=jI3X9XqmjPrIXRjEhmKfdAUI1irN5sRD7dsad8ywor1WUzgaQh8IRMMyZXjT9ikxH+
 CyfAvviO4fVFdmLgHj/V4I5L+pkFdRiaanP1zFmORFTBkEJ7an8sy9UCTpuWqp4eEKVv
 Px8GJQQDWH7dMcEkASYtEbsurHZojh5SGmUos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755698815; x=1756303615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hNNqYmm+2vddCaU7g4pO2qOZseIDzXWLw/uBxiAOMEk=;
 b=q27gzyECQ5YblUQ6goQ54D+ZJqDI3fyVjf0Ax9KGNOCTz9M1ZbiCTdRHnCmgMMxEr1
 xbqZ8q2mS3P8pdRUfBoxz8TeCK69EWhYnl81argOEEaTVfHtvzwweB/hWI2tIqu3WRK8
 7+jton3fxKfrmyVMPcN5YQBKX0b6bJPloc1ok3obRlX0zeNtSZKsBf37AYkAKLshNjNb
 djP2j5pldbg0JsP2mGkD2mvLjNouftFmVaYOHWPWrraId0UEnjMzvdrEVvBYrQ6Ee7vH
 xJfOPJXsNxRdGbnBWWx2LnnYrpOuhS1mWEjU+UslUw9EcbPUEtbws/OdwtS4td1X9SZe
 /V1g==
X-Gm-Message-State: AOJu0YynIShbGpa4G1vhvUuY5+yk+A76vUGhVmk2qhaXjYssxRRs2ZDv
 wsg9oNTZUvmdzFBNBeTCqzDQpW7Mq1jmwOvPEQw4bxVKgmOliyyY9+bGJ9cYePQ4jM20Bj/y2C1
 uBjIe
X-Gm-Gg: ASbGncsBOvgga4hCC5ZVMLZ63KTnnmbc0ozPXcVu5TiH/O1+kTBBEGBDMxfzAkTAq4v
 GCQY68/lEDvTjWqEMe1eDBbEFMGdgrwt8jaWS6OMLOykENDk3PwFyBTDhV/cIbhLOt0wRyzpxCh
 m9+avllkNHk3PfSs14RQraIy2u+f1mKqZOY0SS0CFeO45uJFX0eeUtU+6YBwnDPi5d2cNyZE12r
 uk4G79pttYYvU07m8aYo66eFHQlN8MT13Z1KAh1rSCuADDv9IQdvxXf05TiCbuF9eQwda4ELRwW
 rkY2Z4AHq8TYKUNN3lftWKRe7e8I7WzcGnFwVFub8IrASH3848u89nMvl35Qy2xwGAkjJo37Nz9
 MehisDwOPJ1pLew==
X-Google-Smtp-Source: AGHT+IFlJoEOpckjF/uAWxmnDB5SBfUBrB4qXM+dveD6a6I4286StQvfGdgNMr2WTTVPhCUar9bgPA==
X-Received: by 2002:a05:6214:5283:b0:70d:6df4:1aed with SMTP id
 6a1803df08f44-70d771d9e88mr27214306d6.59.1755698814629; 
 Wed, 20 Aug 2025 07:06:54 -0700 (PDT)
Received: from d121016.iol.unh.edu ([2606:4100:3880:1210::202])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-70ba92f924bsm88806816d6.46.2025.08.20.07.06.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Aug 2025 07:06:52 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v3 0/2] dts: change default topology to one link
Date: Wed, 20 Aug 2025 10:06:49 -0400
Message-ID: <20250820140651.39604-1-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250807140730.292639-1-dmarx@iol.unh.edu>
References: <20250807140730.292639-1-dmarx@iol.unh.edu>
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

Currently, when the topology of a test suite is not specified,
it defaults to two_link. This may be counterintuitive to users,
and can slow down the process of getting a test suite running.
This series changes the default to one_link, and refactors the
topology decorators accordingly.

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
---
v2:
* Grouped one_link default and two_link requirements patches

v3:
* Remove one_link suite decorators
* Add two_link requirement to one_port_blocklisted case

Dean Marx (2):
  dts: make one link the default topology
  dts: rewrite two link topology requirements

 dts/framework/testbed_model/topology.py | 2 +-
 dts/tests/TestSuite_blocklist.py        | 4 +++-
 dts/tests/TestSuite_checksum_offload.py | 2 +-
 dts/tests/TestSuite_dynamic_config.py   | 2 +-
 dts/tests/TestSuite_port_control.py     | 2 +-
 dts/tests/TestSuite_uni_pkt.py          | 2 +-
 dts/tests/TestSuite_vlan.py             | 2 +-
 7 files changed, 9 insertions(+), 7 deletions(-)

-- 
2.50.1

