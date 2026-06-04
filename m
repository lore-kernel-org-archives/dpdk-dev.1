Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A8FCD6E77
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 16:55:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 158674067D;
	Thu,  4 Jun 2026 18:55:36 +0200 (CEST)
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
 by mails.dpdk.org (Postfix) with ESMTP id 2B26B4064E
 for <dev@dpdk.org>; Thu,  4 Jun 2026 18:55:34 +0200 (CEST)
Received: by mail-dl1-f41.google.com with SMTP id
 a92af1059eb24-1363fe80fe8so1412503c88.0
 for <dev@dpdk.org>; Thu, 04 Jun 2026 09:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780592133;
 x=1781196933; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rDkCVHuaTd7PIuRE9AQPBuLllDU9Ju1H3GSTTND4jNo=;
 b=pj3mLpzI70pEXGMps4mGz3dFZDvPJ5pauHFzz//Pw96N2ElMT3bZ4QUMc/RCVsLxWM
 rPvA7zducYDVaGtOiGk7c4iwn7ZRWsirafwvcDeBts3Nj+51zL/XwIaj0VnX/LVXxdHN
 XVLYcaHqeEhG2YIN6V7TqDCF9w0mxU7We45ifCV8NvESjwya+RtiJGYrfBf4q1CIo0QB
 QFe+QMRhQoGQS1riCXIc0xkEMdaNNBqD45XbnOmuGhN+iDCPzSxQA+xsGYVYpsQJFl0M
 B9oSD0flVJrxQ/w9DOnY9ScUJHzsYjfPgfT39NBCDVC4uh/2txX/6T90FQcM4gKircca
 J9Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780592133; x=1781196933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rDkCVHuaTd7PIuRE9AQPBuLllDU9Ju1H3GSTTND4jNo=;
 b=NSqZUAi30/UwOrAQLU/IN+ZlLNzBR9kEp6k+XeUrHCl8SiHYjqZ6c3uKZYxPX17Fwq
 csiE2GhH5LLwwevSaaKfkuEfsDoV6f+iCxnBFbron8B6Ik1dysQgsg+dNHfeU9yxnMj5
 PBHc6FcD2/ngfISsH+r4+33DQh5u/vbbJB1mnyc5yr7PgzmLLAAPcTMuxdB5MtXBupC9
 XNWGVxmSfmZWFouj//+HAg+xD2LqkNe8RhKf3vk5G7Md1VCI2z4Z3mYXSTrzLukksaVx
 BIVs2QMqxgEi98U2iFM4rlMVurEyViV64ij7n3VZqIGHOV0imx8LOInuTTEG3vFIU/fb
 pcCw==
X-Gm-Message-State: AOJu0YwntHBEI3WAorgR22KFGkuMeiSZahAxhAaIvm5jDdNS0vWzyRLi
 1a2ElVJtQpi+sRxg81dA1+jAdFrLDiZiBjuSluDY7ohc7EUtqhuE/ho4jWP7LzKpY+g=
X-Gm-Gg: Acq92OFcv6Hf1DFophRIkG7OhV1zxFVcqgvxVE8Qtn0TQUtkwYYP68+b5GdNkau3XYt
 YQraAdl9mFQhhJ1A2P1Bq16xs7xPZrsYI2ZEf1yHR9SGNs2EyXATeNsS2JlCOFn1fis8PUBTMdl
 rDDVB7WB5/ZbBo/6i+ZMMqxiH4saNHtBkVeU98EY1q1vz830ywemWVHwYC7TLVpR3kRx+XLXfgA
 rsA/Gh2tTMs+QoBbDu99edmEjCpfc4gbvMBXcq65s4CWMx+IBNg63XR33Y+7cPyZw6H63E5Fimi
 a/iBJdTFi8Mw/WjAPhQXSygH15qOeUMvMD6ESi9iwBUdl2eXtUeoz68NBRpIS9bAWZwDCL8xi+U
 /4YBIk70DDXJ+vpgKnVFwxlV1QV8aehabUWYxDd5ldPJ7mSU/Gt4FP+0JP/AnsIW1/uRN+B0f+y
 Mj2VeIV+QKU0izuoTV5oR+oIy7g+WKWpKvgcRBqm9Q5i61lvy1yj//kpdMAPtV9p2Lz/2NiaIEn
 DEVX9TZuHJHPQ==
X-Received: by 2002:a05:7022:eaca:b0:137:fb6c:5355 with SMTP id
 a92af1059eb24-137fb6c5512mr3058851c88.3.1780592132770; 
 Thu, 04 Jun 2026 09:55:32 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137f716017esm5395253c88.15.2026.06.04.09.55.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 09:55:32 -0700 (PDT)
Date: Thu, 4 Jun 2026 09:55:29 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Denis Sergeev <denserg.edu@gmail.com>
Cc: dev@dpdk.org, shepard.siegel@atomicrules.com, ed.czeck@atomicrules.com,
 john.miller@atomicrules.com, stable@dpdk.org
Subject: Re: [PATCH v2] net/ark: use standard IPv4 address parser
Message-ID: <20260604095529.0e9f7f04@phoenix.local>
In-Reply-To: <20260604034837.250221-1-denserg.edu@gmail.com>
References: <20260603054742.120101-1-denserg.edu@gmail.com>
 <20260604034837.250221-1-denserg.edu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Thu,  4 Jun 2026 06:48:37 +0300
Denis Sergeev <denserg.edu@gmail.com> wrote:

> The IPv4 parsing helper used by pktgen and pktchkr read each octet with
> "%u", which accepts values above 255 from the configuration file and
> encodes them into unintended device register values.
> 
> Replace the hand-rolled parser in both modules with inet_pton(), which
> validates the dotted-quad format and the octet range, and matches the
> IPv4 parsing already used by other DPDK drivers. For valid input the
> returned value is byte-order identical to the previous helper, so the
> register contents are unchanged.
> 
> Fixes: 9c7188a68d7b ("net/ark: provide API for hardware modules pktchkr and pktgen")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Denis Sergeev <denserg.edu@gmail.com>
> ---

I think you need an additional header.

FAILED: drivers/libtmp_rte_net_ark.a.p/net_ark_ark_pktchkr.c.o
cc -Idrivers/libtmp_rte_net_ark.a.p -Idrivers -I../drivers -Idrivers/net/ark -I../drivers/net/ark -Ilib/ethdev -I../lib/ethdev -Ilib/eal/common -I../lib/eal/common -I. -I.. -Iconfig -I../config -Ilib/eal/include -I../lib/eal/include -Ilib/eal/freebsd/include -I../lib/eal/freebsd/include -Ilib/eal/x86/include -I../lib/eal/x86/include -Ilib/eal -I../lib/eal -Ilib/kvargs -I../lib/kvargs -Ilib/log -I../lib/log -Ilib/metrics -I../lib/metrics -Ilib/telemetry -I../lib/telemetry -Ilib/argparse -I../lib/argparse -Ilib/net -I../lib/net -Ilib/mbuf -I../lib/mbuf -Ilib/mempool -I../lib/mempool -Ilib/ring -I../lib/ring -Ilib/meter -I../lib/meter -Idrivers/bus/pci -I../drivers/bus/pci -I../drivers/bus/pci/bsd -Ilib/pci -I../lib/pci -Idrivers/bus/vdev -I../drivers/bus/vdev -Xclang -fcolor-diagnostics -pipe -D_FILE_OFFSET_BITS=64 -Wall -Winvalid-pch -Wextra -Werror -std=c11 -O3 -include rte_config.h -Wvla -Wcast-qual -Wcomma -Wdeprecated -Wformat -Wformat-nonliteral -Wformat-security -Wmissing-declar
 ations -Wmissing-prototypes -Wnested-externs -Wold-style-definition -Wpointer-arith -Wshadow -Wsign-compare -Wstrict-prototypes -Wundef -Wwrite-strings -Wno-missing-field-initializers -D_GNU_SOURCE -D__BSD_VISIBLE -fPIC -march=native -mrtm -DALLOW_EXPERIMENTAL_API -DALLOW_INTERNAL_API -Wno-format-truncation -Wno-address-of-packed-member -DRTE_LOG_DEFAULT_LOGTYPE=pmd.net.ark -DRTE_ANNOTATE_LOCKS -Wthread-safety -MD -MQ drivers/libtmp_rte_net_ark.a.p/net_ark_ark_pktchkr.c.o -MF drivers/libtmp_rte_net_ark.a.p/net_ark_ark_pktchkr.c.o.d -o drivers/libtmp_rte_net_ark.a.p/net_ark_ark_pktchkr.c.o -c ../drivers/net/ark/ark_pktchkr.c
../drivers/net/ark/ark_pktchkr.c:381:16: error: use of undeclared identifier 'AF_INET'
381 |         if (inet_pton(AF_INET, ip_address, &addr) != 1)
