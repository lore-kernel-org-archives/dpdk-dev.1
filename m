Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B068CE8383C
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 22:12:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EC0A640289;
	Mon, 16 Feb 2026 23:12:58 +0100 (CET)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44]) by mails.dpdk.org (Postfix) with ESMTP id C72054026C
 for <dev@dpdk.org>; Mon, 16 Feb 2026 23:12:56 +0100 (CET)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-436234ef0f0so2499637f8f.1
 for <dev@dpdk.org>; Mon, 16 Feb 2026 14:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771279976;
 x=1771884776; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EbLthgYha1T/ug4xdRn7lM8o1emQOxHunl5Nut+5SeM=;
 b=QbyN90pA+EkRwQEy12oWPiKpHpMun3tN7dCZ5emNvz5PAsZE6G4PmlijFuC2mLc8qU
 xmjvP62vZDQusm5Z4KMV92VJQdiUb1kWPMwwg4Gtn7E5Re4aAYhz+MYHjJDV3nmUPtw9
 aW8iXa4opYIfF1qB+yq3IpJ2n3fL4KBsqexEWhY/mCVGGnkurfR+AbRvyFjFQkyhJJzq
 3RHiapnC3Bktrxs7+QC9xO0+tukrHqzFOLpfeZKu1Fh44ANOUF4V62iPWLDSL4WqZwCs
 jqCDAaxz0u6RHGtRZO0OZGnIor9AhZ5aJ/25Y7tl+WHbTvNO0kb1XXKthV9mLEYZ+/RH
 Xplg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771279976; x=1771884776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EbLthgYha1T/ug4xdRn7lM8o1emQOxHunl5Nut+5SeM=;
 b=VkIaF0ez+mcvHjddtotcUSIQNzqElE1OIq7zgDIWYMAwgX8t4vMkslKrFMcX/ruT7J
 E2y5jw7FiPmud8NqyGUvOFmwVqZCcW7W6u+d9RY0W4ELNSV6C1C/Sx2vHmW3kdpNc/xg
 9y4VyzxmqA0wPagb75ho+kMRdRr7v5ss97dUJMv1LjLiXN7CHP/JTObEQFCSIOdS7Mt5
 6CWT+C3qk7a4VG0JDnLyOPxCAgBbXbyKVcdsHJ/4nttifd+tQKLBPCt6mmmJvsVvDT8+
 5xl5MhM0yEod9g3HI2usjGU0SikMKp4WjBNiYTVlnj6fI2/mSR9mcsEVbToIba8HyMHS
 dpLg==
X-Gm-Message-State: AOJu0Yw0tLIGdKsQdH6+R/ZBd53fKegv4b6gyGVMUi709SeWgCrPYvFE
 Q0YNlQl5XVEFAvjOYyEoyCiIRJsEaabMONtLLfhtjHwl+GmqPRe3Mc/eokym1Cn334M=
X-Gm-Gg: AZuq6aIrTu0AKmx5hmJXIxPHLyk0NGw08kILhDVsJH8ggspPHppMvjNId6Hq3rWnPLF
 +tS53SzoYECxDdxbSRlZezdF3jallyyIsU0b5RJbrOsZBv3AZOEvtRRxvO8Aw059Eb2UdJemZxC
 HTrTVIrDXOzwV+VSzBkz5GNISoP+P4uIlyU4Ip58eCyO05Njbdrdwj5FSwhhLnXUxpFJXmJWfGO
 S6D+ozjCWq1p/t9bagdlf/Tsf/DIGx0NRqpLOiIEnSGsLthlLH+87SRM1ciTM4QeXoGJTdLjF88
 6jetygnsxncT00VwzPBX599es3Vr/MjUfOl35RQYfSHYYy+BWGLdOqz0LEUjn/1oO3LSyn4+fAM
 AvMz3yDbPhg7iqg8oNP3+b6Xo+7hehl3zBIKIgCTmPjB6xaikajeBGiS3nwvlAAp+1aHg2Lb18h
 elgHvwpPyJkr/zSM6pmvYilglDZ7u7xpwcM3T64hKPJFN0QvNfFY/EpRz1phhx3HDe
X-Received: by 2002:a5d:526e:0:b0:437:9ccf:6b20 with SMTP id
 ffacd0b85a97d-4379ccf6b47mr14706940f8f.55.1771279976336; 
 Mon, 16 Feb 2026 14:12:56 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796a5ac7csm26640790f8f.7.2026.02.16.14.12.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 14:12:56 -0800 (PST)
Date: Mon, 16 Feb 2026 14:12:52 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ashok Kumar Natarajan <ashokkumar.natarajan@amd.com>
Cc: <dev@dpdk.org>, <Selwin.Sebastian@amd.com>
Subject: Re: [PATCH] net/axgbe: added marvel m88e1512 PHY support
Message-ID: <20260216141252.76f2b567@phoenix.local>
In-Reply-To: <20260216085431.972-1-ashokkumar.natarajan@amd.com>
References: <20260216085431.972-1-ashokkumar.natarajan@amd.com>
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

On Mon, 16 Feb 2026 14:24:31 +0530
Ashok Kumar Natarajan <ashokkumar.natarajan@amd.com> wrote:

> Added marvel m88e1512 1G PHY support in amd axgbe driver
>=20
> Signed-off-by: Ashok Kumar Natarajan <ashokkumar.natarajan@amd.com>

Multiple CI build failures. Fix and resubmit.
FAILED: drivers/libtmp_rte_net_axgbe.a.p/net_axgbe_axgbe_phy_impl.c.o=20
clang -Idrivers/libtmp_rte_net_axgbe.a.p -Idrivers -I../drivers -Idrivers/n=
et/axgbe -I../drivers/net/axgbe -Ilib/ethdev -I../lib/ethdev -Ilib/eal/comm=
on -I../lib/eal/common -I. -I.. -Iconfig -I../config -Ilib/eal/include -I..=
/lib/eal/include -Ilib/eal/linux/include -I../lib/eal/linux/include -Ilib/e=
al/x86/include -I../lib/eal/x86/include -I../kernel/linux -Ilib/eal -I../li=
b/eal -Ilib/kvargs -I../lib/kvargs -Ilib/log -I../lib/log -Ilib/metrics -I.=
./lib/metrics -Ilib/telemetry -I../lib/telemetry -Ilib/argparse -I../lib/ar=
gparse -Ilib/net -I../lib/net -Ilib/mbuf -I../lib/mbuf -Ilib/mempool -I../l=
ib/mempool -Ilib/ring -I../lib/ring -Ilib/meter -I../lib/meter -Idrivers/bu=
s/pci -I../drivers/bus/pci -I../drivers/bus/pci/linux -Ilib/pci -I../lib/pc=
i -Idrivers/bus/vdev -I../drivers/bus/vdev -fcolor-diagnostics -D_FILE_OFFS=
ET_BITS=3D64 -Wall -Winvalid-pch -Wextra -Werror -std=3Dc11 -O3 -include rt=
e_config.h -Wvla -Wcast-qual -Wcomma -Wdeprecated -Wformat -Wformat-nonlite=
ral -Wformat-security -Wmissing-declarations -Wmissing-prototypes -Wnested-=
externs -Wold-style-definition -Wpointer-arith -Wshadow -Wsign-compare -Wst=
rict-prototypes -Wundef -Wwrite-strings -Wno-missing-field-initializers -D_=
GNU_SOURCE -fPIC -march=3Dnative -mrtm -DALLOW_EXPERIMENTAL_API -DALLOW_INT=
ERNAL_API -Wno-format-truncation -Wno-address-of-packed-member -Wno-comma -=
Wno-cast-qual -Wno-shadow -DRTE_LOG_DEFAULT_LOGTYPE=3Dpmd.net.axgbe -DRTE_A=
NNOTATE_LOCKS -Wthread-safety -MD -MQ drivers/libtmp_rte_net_axgbe.a.p/net_=
axgbe_axgbe_phy_impl.c.o -MF drivers/libtmp_rte_net_axgbe.a.p/net_axgbe_axg=
be_phy_impl.c.o.d -o drivers/libtmp_rte_net_axgbe.a.p/net_axgbe_axgbe_phy_i=
mpl.c.o -c ../drivers/net/axgbe/axgbe_phy_impl.c
../drivers/net/axgbe/axgbe_phy_impl.c:2359:6: error: variable 'ret' is used=
 uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uniniti=
alized]
 2359 |         if (bmcr =3D=3D -1)
      |             ^~~~~~~~~~
../drivers/net/axgbe/axgbe_phy_impl.c:2368:9: note: uninitialized use occur=
s here
 2368 |         return ret;
      |                ^~~
../drivers/net/axgbe/axgbe_phy_impl.c:2359:2: note: remove the 'if' if its =
condition is always false
 2359 |         if (bmcr =3D=3D -1)
      |         ^~~~~~~~~~~~~~~
 2360 |                 goto out;
      |                 ~~~~~~~~
../drivers/net/axgbe/axgbe_phy_impl.c:2356:9: note: initialize the variable=
 'ret' to silence this warning
 2356 |         int ret;
      |                ^
      |                 =3D 0
