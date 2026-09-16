Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124FFC88E5C
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 12:59:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 467DF42EE0;
	Wed, 16 Sep 2026 14:59:49 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id A6C9A40E12
 for <dev@dpdk.org>; Wed, 16 Sep 2026 14:59:47 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=uev3fDM76T7Jgc1EWnvT5E3uJYkh1BCStkDms6qLowc=;
 b=QVMTwh+EXmfZYvIMaRKYOmlkSf68UHOJVy1W30NMfWPl/65YQLhnPXSzNLg1AKpJsn6zq6Mj3
 d0E9xAOvr3xk1QDmR5NWsxqgr3O55xU4E80O1t7Tl2bAg4OGeFsFdcNmDwCGsDyZNbExTzpZmoo
 1MDKDU8xygitJm74Kje6vxQ=
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4hlJqG5Cw2zJ46Zl;
 Wed, 16 Sep 2026 20:58:50 +0800 (CST)
Received: from dubpeml100003.china.huawei.com (unknown [7.214.147.98])
 by mail.maildlp.com (Postfix) with ESMTPS id 47B5540575;
 Wed, 16 Sep 2026 20:59:45 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml100003.china.huawei.com (7.214.147.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 13:59:44 +0100
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.2562.046; 
 Wed, 16 Sep 2026 13:59:44 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Marat Khalili <marat.khalili@huawei.com>, Wathsala Vithanage
 <wathsala.vithanage@arm.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH v2 1/2] bpf: make bpf_def.h private
Thread-Topic: [PATCH v2 1/2] bpf: make bpf_def.h private
Thread-Index: AQHdQetcmVMxH8/ACE6HRzWRsXfDZbbRMipQ
Date: Wed, 16 Sep 2026 12:59:44 +0000
Message-ID: <49e32535a57345dba590877bc861bb30@huawei.com>
References: <20260805094642.52433-1-marat.khalili@huawei.com>
 <20260911124414.63321-1-marat.khalili@huawei.com>
 <20260911124414.63321-2-marat.khalili@huawei.com>
In-Reply-To: <20260911124414.63321-2-marat.khalili@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.195.247.58]
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



> Both `bpf_def.h` header file and the symbols it defined were not
> previously prefixed with `rte_`, creating an opportunity for name
> conflicts. Status of the file itself (private or public) was unclear.
>=20
> Move public symbols after adding the necessary prefix (`rte_ebpf_insn`
> and `RTE_BPF_FUNC_MAX_ARGS`) into the public header file `rte_bpf.h`,
> and make the rest private.
>=20
> Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
> ---

Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
As it is a public API change - It is probably worth a line or two in offici=
al RN for 26.11

> --
> 2.43.0

