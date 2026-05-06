Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD06CD3436
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 May 2026 10:10:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2EA59402A7;
	Wed,  6 May 2026 12:10:45 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id DD8C040285
 for <dev@dpdk.org>; Wed,  6 May 2026 12:10:43 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4g9WNK6JBHzJ46DY;
 Wed,  6 May 2026 18:10:25 +0800 (CST)
Received: from dubpeml500002.china.huawei.com (unknown [7.214.145.83])
 by mail.maildlp.com (Postfix) with ESMTPS id C504C40584;
 Wed,  6 May 2026 18:10:42 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml500002.china.huawei.com (7.214.145.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 6 May 2026 11:10:42 +0100
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Wed, 6 May 2026 11:10:42 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Bruce Richardson <bruce.richardson@intel.com>, Stephen Hemminger
 <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [RFC 1/3] flow_compile: introduce textual flow rule compiler
Thread-Topic: [RFC 1/3] flow_compile: introduce textual flow rule compiler
Thread-Index: AQHc3Qk4jWl/n+hePkWS7oSKlrHR1bYAk50AgAAyE3A=
Date: Wed, 6 May 2026 10:10:42 +0000
Message-ID: <ecdc2ac7f46f4f8095fa384121dac419@huawei.com>
References: <20260505183917.370281-1-sismis@dyna-nic.com>
 <20260506033338.480610-1-stephen@networkplumber.org>
 <20260506033338.480610-2-stephen@networkplumber.org>
 <afr2frTWMC3kGKxq@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <afr2frTWMC3kGKxq@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.195.35.76]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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


> On Tue, May 05, 2026 at 08:29:55PM -0700, Stephen Hemminger wrote:
> > Currently the only way to compile a flow rule from text is to link
> > against testpmd's cmdline_flow.c, which is tightly coupled to
> > librte_cmdline and the testpmd command framework.  Recent attempts
> > to extract it as a library have produced ad-hoc copies rather than
> > a clean separation.
> >
> > Add librte_flow_compile, modelled on libpcap's pcap_compile(): a
> > textual rule goes in, an opaque compiled object comes out, and
> > diagnostics of the form "line:col: message" go in a caller-supplied
> > buffer.  Accessors return the rte_flow_attr/item/action arrays
> > ready for rte_flow_create(); a convenience entry point installs
> > the rule directly on a port.
> >
> > The parser is recursive descent driven by descriptor tables of
> > items and actions, so adding a new item type is purely a table
> > edit -- the parser has no per-type knowledge.  A custom-setter
> > hook handles fields whose layout cannot be expressed as a plain
> > byte range (bitfields, indirect arrays).
> >
> > Dependencies are limited to rte_ethdev and rte_net; no
> > librte_cmdline, no flex/bison, no platform-specific headers.
> > The grammar follows testpmd's syntax so familiar rules carry
> > over and is documented in the programmer's guide.
> >
> Was there a particular reason to avoid using flex/bison here, or did thei=
r
> use just not make sense? In general I would prefer using code-generation
> tools where possible rather than maintaining (metaphorically) hand-writte=
n
> code.

In general, I like the idea of flow_compile(const char *) and the idea to m=
ake
it independent from cmdline lib.
Though I have the same question as Bruce: why not to use flex/bison here?
At first glance, that's the right tools for that kind of job and seems much=
 better
then hand-written (AI generated) peace of code that no-one would probably u=
nderstand.=20
Konstantin
