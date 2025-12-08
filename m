Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7178D3B7E2
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Dec 2025 21:48:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BE6FF4028C;
	Mon,  8 Dec 2025 22:48:08 +0100 (CET)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50]) by mails.dpdk.org (Postfix) with ESMTP id 5A5234025F
 for <dev@dpdk.org>; Mon,  8 Dec 2025 22:48:07 +0100 (CET)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-42e2b90ad22so1841497f8f.2
 for <dev@dpdk.org>; Mon, 08 Dec 2025 13:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1765230487;
 x=1765835287; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:subject:cc:to
 :from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MOwULKAUj9XSEklC9qVQb0/g6azLXf8qS40/daaw6uE=;
 b=we2yVv/J3oVuoqBrQ8tnyAXMxBP98Dv+tB0jMwHVEdP3EYUx3YQ1B+3qhnOi1cg20p
 +d0BYMTeUNERL9KobZg5/Rktnk55HlT4PIMrVeeJvoROVtlB25lqXijsOGf/Eq/Mfx6A
 S+Dg3geft6Ygn17ecD5U+JTHpiNxX3yBfRkZz2Nc2vOz23UtT2lJpOAwULKJ9wAcSkvv
 0ft4ZawhEju06oAgwKux1Jk/sYB3jGdx3mV/Z8el7m02UcW4oMdMf1tgIsxEAfS5O9Qi
 jmQjcbY7QrO9Y4v26GrgU3qq0j5gyITDfyje9nvDbWrBXkhBAmyQm0wPFx4O3D0lqeCv
 j3Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765230487; x=1765835287;
 h=content-transfer-encoding:mime-version:message-id:subject:cc:to
 :from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MOwULKAUj9XSEklC9qVQb0/g6azLXf8qS40/daaw6uE=;
 b=fkwrqpioYIRehN7D17C9gPYbfSe5k9TrCwZMJAM6DOuW7INHu3qSkL6WPrO5N6l865
 W3DMbPyuwp0ITHNLdFc8BMwOZageSDPx1A18kk0jKuFD7Qqi183po1r3k4vtt2GxYevB
 vXNYLdVK3iAs3U6HUOyLbdBpjjM+jDzbb2WYhBv/Wpg+Mghk5mSp5bB5zJIyzvhdNBvQ
 wtFY0LNBg8g3KK4V6YDVnJFGYb3CGmxayAUKcjT4yP+Ke7tBi4OQ495YijLGSNLfyVWO
 8zPO0K7zA/X9OkbPT2iElZD8RZJz837hRdRZdWWfP2l6QJbAzJYIeDi4buT5FgUnECl8
 9KJw==
X-Gm-Message-State: AOJu0Ywzf16e01C82WijOhLhb6nGfoCI1P5o4xoUzynW2a+Zf0k8ESqx
 CgEgCxMAgGNdEmtMD+7dHk3uwtmSpvnwqR1IALHVRrfhE4xVC58Pk3x7DXrH1rGpwS4=
X-Gm-Gg: ASbGncupfbE8kh9ysDM0J9336QvFoxvsrSb5l997PpIJP6kri3i6i8zW8FsNiQWQ7cK
 p/Hy78AO9sF3hHo/N4TmPHyRYaI1W42Gqnys8BZA135wtZumWlylyRXcnYB/4yKSGO7quQv+MzS
 hIz2+ev+psFTBybdeo0gzh9iBEYG3q0uDS8jAVwWoP+as/cWyEr52mK0FMPVF4DBllQDYW1LOgq
 neB9KCcAqzv7uU1m7rQNAsYMUbTrO8kbCod6utmPZgjSMqmAOAwSUiWnbt/Pw4TFsxVSZWP4X58
 eR8Z43LMEcen82tDFsT2UqM2kKyQn3acGFcwFgt7l93X0t2RI/HRBjBZDRXxE1+Ma2ZYrmkYOKp
 9RCkuefPtlQoOHtJRoOdz0GnArvEP+QU1cQukG0EMvBDgW4ENataRxxJkXu4dWoI0zR1+1m++sl
 Fnu+nWR86RfPZWxXdaBAiTD52ZazcDMaY+0+7HnzFWh0m6uETSuPzc
X-Google-Smtp-Source: AGHT+IGSLso1H2qohfG6QNB+7wGaykPIWYsbAnW6f/ckeocON5FoIoKte7Db+zuf6SP1C6lluHktlQ==
X-Received: by 2002:a5d:5f51:0:b0:42b:3ed2:c08b with SMTP id
 ffacd0b85a97d-42f89f574ffmr8836586f8f.51.1765230486677; 
 Mon, 08 Dec 2025 13:48:06 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7d222491sm29100474f8f.22.2025.12.08.13.48.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Dec 2025 13:48:06 -0800 (PST)
Date: Mon, 8 Dec 2025 13:48:00 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Wathsala Vithanage <wathsala.vithanage@arm.com>
Cc: dev@dpdk.org
Subject: MS-R1 ARM support
Message-ID: <20251208134800.6889316d@phoenix.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
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

I just got a new mini-PC ARM system. Which has 2 100G Realtek ports
and PCI express slot. Which seemed like a good box for ARM testing.

The ARM configuration in meson doesn't seem to know this CPU type.

config/arm/meson.build:947:8: ERROR: Problem encountered: Unsupported part =
number 0xd81 of implementer 0x41. Please add support for it or use the gene=
ric (-Dplatform=3Dgeneric) build.

My simplistic attempt to add was:


part_number_config_arm =3D {
...
    '0xd81': {
        'mcpu' : 'cortex-a72.cortex-a53',
        'flags': [
            ['RTE_MACHINE', '"cortex-a720"'],
            ['RTE_ARM_FEATURE_ATOMICS', true],
            ['RTE_ARM_FEATURE_WFXT', true],
            ['RTE_MAX_LCORE', 128],
            ['RTE_MAX_NUMA_NODES', 2]
        ]
    },

But then power won't build

FAILED: lib/librte_eal.a.p/eal_arm_rte_power_intrinsics.c.o=20
cc -Ilib/librte_eal.a.p -Ilib -I../lib -Ilib/eal/common -I../lib/eal/common=
 -I. -I.. -Iconfig -I../config -Ilib/eal/include -I../lib/eal/include -Ilib=
/eal/linux/include -I../lib/eal/linux/include -Ilib/eal/arm/include -I../li=
b/eal/arm/include -I../kernel/linux -Ilib/eal -I../lib/eal -Ilib/kvargs -I.=
./lib/kvargs -Ilib/log -I../lib/log -Ilib/metrics -I../lib/metrics -Ilib/te=
lemetry -I../lib/telemetry -Ilib/argparse -I../lib/argparse -fdiagnostics-c=
olor=3Dalways -D_FILE_OFFSET_BITS=3D64 -Wall -Winvalid-pch -Wextra -std=3Dc=
11 -O3 -include rte_config.h -Wvla -Wcast-qual -Wdeprecated -Wformat -Wform=
at-nonliteral -Wformat-security -Wmissing-declarations -Wmissing-prototypes=
 -Wnested-externs -Wold-style-definition -Wpointer-arith -Wsign-compare -Ws=
trict-prototypes -Wundef -Wwrite-strings -Wno-packed-not-aligned -Wno-missi=
ng-field-initializers -D_GNU_SOURCE -fPIC -mcpu=3Dcortex-a72.cortex-a53 -DA=
LLOW_EXPERIMENTAL_API -DALLOW_INTERNAL_API -Wno-format-truncation '-DABI_VE=
RSION=3D"26.1"' -DRTE_EAL_PTHREAD_ATTR_SETAFFINITY_NP -DRTE_LOG_DEFAULT_LOG=
TYPE=3Dlib.eal -MD -MQ lib/librte_eal.a.p/eal_arm_rte_power_intrinsics.c.o =
-MF lib/librte_eal.a.p/eal_arm_rte_power_intrinsics.c.o.d -o lib/librte_eal=
.a.p/eal_arm_rte_power_intrinsics.c.o -c ../lib/eal/arm/rte_power_intrinsic=
s.c
/tmp/ccSpmqE0.s: Assembler messages:
/tmp/ccSpmqE0.s:80: Error: selected processor does not support `wfet x1'
[117/3873] Compiling C object lib/librte_ring.a.p/ring_soring.c.o

Not sure what the best option. Looks like this an Android style CPU with bi=
g/little.

Any ARM expertise would help here.
Posting on mailing list so that others can find the answer.
