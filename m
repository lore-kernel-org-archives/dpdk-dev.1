Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B060C5CFE6
	for <dpdk-dev@archiver.kernel.org>; Sat, 21 Feb 2026 16:26:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1E72F4025A;
	Sat, 21 Feb 2026 17:26:55 +0100 (CET)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com
 [209.85.219.47]) by mails.dpdk.org (Postfix) with ESMTP id 193BA40150
 for <dev@dpdk.org>; Sat, 21 Feb 2026 17:26:53 +0100 (CET)
Received: by mail-qv1-f47.google.com with SMTP id
 6a1803df08f44-897002b7576so38618886d6.3
 for <dev@dpdk.org>; Sat, 21 Feb 2026 08:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771691212;
 x=1772296012; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QE34Wjr+/D+EGOVDOmqbzvV0U3kO40ObKIZc+dqzHH4=;
 b=yQr77l75riQONHv/pGjQD6zz+kfAYEZSJA3Fhc6wvvH4YSP58MOMt6nvK548NO5nCc
 +bZyFP+I31RWzC8Ls8clTIt0ScEyt8bQV8LskjHc1qScRRHIMiIjEN4mBKgzp+GF7ytZ
 zcZJMsZIJA5mhRRzeonQ9Qdg5wiCy1hRD2n1byhK/ENmvERixeAbFT7FgbGeB7bDkCFb
 eeYoiBVgL3zFvZOLv1mD45LY85WsBgBx3KUIbhi2yIPU9uTBGupAnsR9oRk2+b2sCtkP
 J6tZCDcYEcuWBvFHlGxx7uraEFPWE+gabURMYroczhe15hu8WdL73qF5SSYvapMd3mF1
 Ammg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771691212; x=1772296012;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QE34Wjr+/D+EGOVDOmqbzvV0U3kO40ObKIZc+dqzHH4=;
 b=jbrak1h2yIkbk7vZMqAFY0KTDs5/KPuB//Q47qbFr8xEi+ijBcEWso4vSv+NawGE42
 b+IsIv2OO8QNAZXNzXGG2W5AA0sRKc9ZksJIOgCdskRp8DVtgDlcNRO6or4LJsG9jy/6
 Ou15Pk7nyuDzdbM/69VdYupfnlRrUVU/tpiVRp5m8rC7/j3umsGsXs/QnMHzPu4Hy7Vm
 HJyEdcO6SqdDRRpuEr71M75wApVAsyGJzpMcsNKExH91SNpFadDBnvbSPL7c1jsbMrPD
 vj83SCLDnD52Wyybj0kbnJ7/I3pxnVBU+T5prZEeJqMc39feI92sQl5zd5iPf+cxzMnD
 ts5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWufSAW7aC5Kur9sRXnqVWNulBtrnKCCc5ykubs5DfcjrHHsf9FTsAKpPVutqkLdw4g2ds=@dpdk.org
X-Gm-Message-State: AOJu0YxamKUU16j9eP4z38/iBVyegd8lI5GEEV3YSa2iPbtQPQppQV/c
 1Std9XV/Ys98VtCmQIaxS6Ecy/8pm7bNd2o50YjdnVkrSOlwM0MBt/qikXSycr6c+NI=
X-Gm-Gg: AZuq6aLMR0HodOlnEGJEZ+hLoEQZP3MrCZ62Qw4IP6gHQbuA9EZjpb43t0MWai33BVR
 Ja4Bz49tc4KoC/83JRiHcBH/XmR61oGA8BDkdnzmyq1zTgE1sJTN91g3mXFZLiAIPKI5YRLE3Br
 EL12JfHJcvSVD1ZsX6lyUqo6tAXnKyTW3bCAYKth7Vnl5a0DRYoj+8IV6Hh7yYg/g7nFybdupMJ
 W0p2PNVESk3vx+ZBKT2RP30BoilNofQKZhR4LDtVmj8e4g+181xohNupRa2h/e8q0Iz5H9JID4L
 960R0rCm8MMSSD3/IL6b73oYCpE+Pzk3iow50IGmjlVOXqaGgAiZEfQIp1C3dxadQLxLTWDBmtl
 PA4ThYNKuzoo/Zy5r4EB5vSptsUK1EcWKcRbjRFpAqx/20CW3ByqcBe1mhcg+a80gXDwSdE9xAN
 84Lx9SuyR7/47wGEYfDIlq44pajThk7ApF4i+FFXbMAK3px2G2DMuIPRO97+eJd/ke
X-Received: by 2002:ac8:7d8e:0:b0:506:a320:e45b with SMTP id
 d75a77b69052e-5070bc6c30fmr48992131cf.39.1771691212115; 
 Sat, 21 Feb 2026 08:26:52 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8997e76f08fsm20952266d6.49.2026.02.21.08.26.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Feb 2026 08:26:51 -0800 (PST)
Date: Sat, 21 Feb 2026 08:26:46 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: <pbhagavatula@marvell.com>
Cc: <mb@smartsharesystems.com>, <jerinj@marvell.com>, Wisam Jaddo
 <wisamm@nvidia.com>, Aman Singh <aman.deep.singh@intel.com>, Chas Williams
 <3chas3@gmail.com>, "Min Hu (Connor)" <humin29@huawei.com>, Akhil Goyal
 <gakhil@marvell.com>, Anoob Joseph <anoobj@marvell.com>, Nicolas Chautru
 <nicolas.chautru@intel.com>, David Hunt <david.hunt@intel.com>, Chengwen
 Feng <fengchengwen@huawei.com>, Kevin Laatz <kevin.laatz@intel.com>, "Bruce
 Richardson" <bruce.richardson@intel.com>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>, Radu Nicolau <radu.nicolau@intel.com>,
 Tomasz Kantecki <tomasz.kantecki@intel.com>, Fan Zhang
 <fanzhang.oss@gmail.com>, Sunil Kumar Kori <skori@marvell.com>, Anatoly
 Burakov <anatoly.burakov@intel.com>, Sivaprasad Tummala
 <sivaprasad.tummala@amd.com>, Jingjing Wu <jingjing.wu@intel.com>,
 Volodymyr Fialko <vfialko@marvell.com>, Cristian Dumitrescu
 <cristian.dumitrescu@intel.com>, John McNamara <john.mcnamara@intel.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>, Chenbo Xia
 <chenbox@nvidia.com>, <dev@dpdk.org>
Subject: Re: [PATCH 2/2] examples: use default mbuf burst size
Message-ID: <20260221082646.4ec49f29@phoenix.local>
In-Reply-To: <20260220230745.26418-2-pbhagavatula@marvell.com>
References: <20251126082414.91933-1-pbhagavatula@marvell.com>
 <20260220230745.26418-1-pbhagavatula@marvell.com>
 <20260220230745.26418-2-pbhagavatula@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Sat, 21 Feb 2026 04:37:44 +0530
<pbhagavatula@marvell.com> wrote:

> From: Pavan Nikhilesh <pbhagavatula@marvell.com>
>=20
> Replace hardcoded burst sizes with RTE_MBUF_BURST_SIZE_DEFAULT
> to adapt to platform-specific optimal burst sizes.
>=20
> Signed-off-by: Pavan Nikhilesh <pbhagavatula@marvell.com>
> ---

This is way to broad. See deeper AI analysis for all the places
this patch is over stepping...

Should only touch examples, and never change the MAX values.
It should not change any drivers.

-----
Patch 2/2: examples: use default mbuf burst size
Error: Semantic mismatch =E2=80=94 evt_options.vector_size set to burst siz=
e macro
In app/test-eventdev/evt_options.c:

=EF=BF=BC
c
-	opt->vector_size =3D 64;
+	opt->vector_size =3D RTE_MBUF_BURST_SIZE_DEFAULT;
The original hardcoded value of 64 for vector_size is an event vector size,=
 not an mbuf burst size. Event vector sizes and mbuf burst sizes serve diff=
erent purposes =E2=80=94 event vectors aggregate events for batch processin=
g and can legitimately be larger than the Rx/Tx burst size. Replacing 64 wi=
th RTE_MBUF_BURST_SIZE_DEFAULT (which defaults to 32 in throughput mode) si=
lently halves the default event vector size on all non-CN10K platforms. Thi=
s is a functional regression that could degrade event-mode throughput. The =
original value should remain 64, or a separate RTE_EVENT_VECTOR_SIZE_DEFAUL=
T macro should be introduced.

Error: MAX_PKT_BURST_VEC reduced from 256 to burst default
In examples/ipsec-secgw/ipsec-secgw.h:

=EF=BF=BC
c
-#define MAX_PKT_BURST_VEC 256
+#define MAX_PKT_BURST_VEC RTE_MBUF_BURST_SIZE_DEFAULT
MAX_PKT_BURST_VEC was intentionally set to 256 for vectorized IPsec process=
ing, which processes packets in large vectorized batches. Reducing it to 32=
 (the default throughput burst size) is a significant behavioral change tha=
t will likely hurt vectorized IPsec performance. This macro also feeds into=
 the MAX_PKTS calculation immediately below it, so the reduction cascades. =
This should either keep 256 or use a separate vector-specific configuration.

Error: MAX_PKT_BURST and DEF_PKT_BURST collapsed to same value in bonding t=
ests
In app/test/test_link_bonding_mode4.c:

=EF=BF=BC
c
-#define MAX_PKT_BURST           (32)
-#define DEF_PKT_BURST           (16)
+#define MAX_PKT_BURST		(RTE_MBUF_BURST_SIZE_DEFAULT)
+#define DEF_PKT_BURST		(RTE_MBUF_BURST_SIZE_DEFAULT)
Originally MAX_PKT_BURST (32) and DEF_PKT_BURST (16) were intentionally dif=
ferent values =E2=80=94 the max is a buffer/array size limit and the defaul=
t is the actual burst count used. Setting both to the same value means the =
test now always bursts at the maximum array size with no headroom. If any c=
ode path allocates MAX_PKT_BURST elements and bursts DEF_PKT_BURST, this di=
stinction is lost. At minimum, DEF_PKT_BURST should remain smaller than MAX=
_PKT_BURST.

Similarly in app/test/test_link_bonding.c, the original DEF_PKT_BURST was 1=
6, now it becomes RTE_MBUF_BURST_SIZE_DEFAULT (32), which equals MAX_PKT_BU=
RST in some cases =E2=80=94 same concern about losing the max/default disti=
nction.

Warning: NTB_MAX_PKT_BURST and NTB_DFLT_PKT_BURST collapsed
In examples/ntb/ntb_fwd.c:

=EF=BF=BC
c
-#define NTB_MAX_PKT_BURST 32
-#define NTB_DFLT_PKT_BURST 32
+#define NTB_MAX_PKT_BURST  RTE_MBUF_BURST_SIZE_DEFAULT
+#define NTB_DFLT_PKT_BURST RTE_MBUF_BURST_SIZE_DEFAULT
These were already the same value (32), so there's no regression today, but=
 the intent of having separate MAX and DEFAULT macros is to allow them to d=
iverge. Replacing both with the same configurable macro permanently ties th=
em together. Consider using RTE_MBUF_BURST_SIZE_DEFAULT only for the defaul=
t and keeping MAX as a separate (potentially larger) constant.

Warning: RTE_MBUF_F_RX_BURST_MAX / RTE_MBUF_F_TX_BURST_MAX naming confusion
In examples/qos_meter/main.c:

=EF=BF=BC
c
-#define RTE_MBUF_F_RX_BURST_MAX                32
-#define RTE_MBUF_F_TX_BURST_MAX                32
+#define RTE_MBUF_F_RX_BURST_MAX		RTE_MBUF_BURST_SIZE_DEFAULT
+#define RTE_MBUF_F_TX_BURST_MAX		RTE_MBUF_BURST_SIZE_DEFAULT
The RTE_MBUF_F_ prefix is reserved for mbuf flags (e.g., RTE_MBUF_F_RX_RSS_=
HASH). These macros are local to the example and not real mbuf flags, but t=
his naming is confusing and was a pre-existing issue. Since this patch is a=
lready touching these lines, it would be a good opportunity to rename them =
to something like QOS_RX_BURST_MAX/QOS_TX_BURST_MAX to avoid namespace conf=
usion.

Warning: PKT_ENQUEUE and PKT_DEQUEUE not updated in qos_sched
In examples/qos_sched/main.h:

=EF=BF=BC
c
 #define MAX_PKT_RX_BURST RTE_MBUF_BURST_SIZE_DEFAULT
 #define PKT_ENQUEUE 64
 #define PKT_DEQUEUE 63
 #define MAX_PKT_TX_BURST RTE_MBUF_BURST_SIZE_DEFAULT
MAX_PKT_RX_BURST and MAX_PKT_TX_BURST are updated from 64 to RTE_MBUF_BURST=
_SIZE_DEFAULT (32), but PKT_ENQUEUE remains hardcoded at 64 and PKT_DEQUEUE=
 at 63. Now the enqueue size is 2=C3=97 the Rx burst size, creating an inco=
nsistency. If these values are related (and they appear to be =E2=80=94 you=
 burst Rx into an enqueue batch), they should be updated together or the re=
lationship should be documented.

Warning: fprintf(stderr, ...) in example code for non-error messages
In examples/l3fwd/main.c, the added else branches print to stderr even when=
 the user explicitly provided a value:

=EF=BF=BC
c
} else {
    fprintf(stderr, "vector size set to (%" PRIu16 ")\n",
        evt_rsrc->vector_size);
}
Using stderr for informational messages (not errors) is unconventional. Thi=
s is example code so it's not critical, but printf or RTE_LOG would be more=
 appropriate for confirming a user-supplied setting.

Warning: Duplicate MAX_PKT_BURST definition
In examples/link_status_interrupt/main.c, MAX_PKT_BURST is defined twice (l=
ines 41 and 63 in the original). Both are being updated, but this pre-exist=
ing duplicate #define should ideally be cleaned up. Since the patch is alre=
ady modifying both lines, removing the duplicate would be a good cleanup.

=EF=BF=BC
=EF=BF=BC
=EF=BF=BC
=EF=BF=BC
