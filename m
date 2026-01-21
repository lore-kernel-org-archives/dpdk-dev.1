Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE0EFC44508
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Jan 2026 19:39:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D909042E69;
	Wed, 21 Jan 2026 20:39:22 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 927F04279D
 for <dev@dpdk.org>; Wed, 21 Jan 2026 20:39:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769024360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k56MJ3q197o2KlXJMzgousLwGFuqDwE7qZ748JVuXfo=;
 b=S65t/ToSj3d5jLaziehMWPi0pzVoINfTAE7bQ8nOgDSc7RRZeZJmNnp2EacfYOoNjTblC3
 KQN3jHCfIvkaUa/z1opQeeX3lEh5FrHcoqhVZaqcCiAHDlbjpNPIw/9rcK5/coZbJQHpSV
 lX7BEYhN14bDcIHXHRN8zjMv3i6nD2k=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-577-0ChZn1x9PiCLaul_KOMm8w-1; Wed,
 21 Jan 2026 14:39:18 -0500
X-MC-Unique: 0ChZn1x9PiCLaul_KOMm8w-1
X-Mimecast-MFC-AGG-ID: 0ChZn1x9PiCLaul_KOMm8w_1769024357
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5CA2D18005AE; Wed, 21 Jan 2026 19:39:17 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.64.171])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5B4B819560BA; Wed, 21 Jan 2026 19:39:16 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: David Marchand <david.marchand@redhat.com>
Cc: Bruce Richardson <bruce.richardson@intel.com>,  Ciara Loftus
 <ciara.loftus@intel.com>,  dev@dpdk.org
Subject: Re: [PATCH v2] net/iavf: support pre and post reset callbacks
In-Reply-To: <CAJFAV8x7mozVaFw0y6n45SRw7PD3Wh9gBV-oXizj4YkWBZPO8Q@mail.gmail.com>
 (David Marchand's message of "Wed, 21 Jan 2026 10:29:18 +0100")
References: <20260113151757.567234-1-ciara.loftus@intel.com>
 <20260114132159.644359-1-ciara.loftus@intel.com>
 <aW_DA9TtPD5cSc_u@bricha3-mobl1.ger.corp.intel.com>
 <CAJFAV8x7mozVaFw0y6n45SRw7PD3Wh9gBV-oXizj4YkWBZPO8Q@mail.gmail.com>
Date: Wed, 21 Jan 2026 14:39:14 -0500
Message-ID: <f7tqzriwyal.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -nx4G-VbchYrvdbOgGdZsyh8woBDKYvRdyTk6lM-I8o_1769024357
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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

David Marchand <david.marchand@redhat.com> writes:

> On Tue, 20 Jan 2026 at 19:02, Bruce Richardson
> <bruce.richardson@intel.com> wrote:
>> >  void
>> >  iavf_set_no_poll(struct iavf_adapter *adapter, bool link_change)
>> >  {
>> > diff --git a/drivers/net/intel/iavf/rte_pmd_iavf.h b/drivers/net/intel/iavf/rte_pmd_iavf.h
>> > index dea1bd2789..d13417eb08 100644
>> > --- a/drivers/net/intel/iavf/rte_pmd_iavf.h
>> > +++ b/drivers/net/intel/iavf/rte_pmd_iavf.h
>> > @@ -20,6 +20,8 @@
>> >  #include <rte_mbuf.h>
>> >  #include <rte_mbuf_dyn.h>
>> >
>> > +#include "iavf.h"
>> > +
>> This include is an issue, because it's an exported i.e. installed, header
>> including a private header that will not be installed as part of DPDK. This
>> gets picked up by running chkincs from test-meson-builds.sh script. [I'm
>> surprised this wasn't caught in the CI].
>
> Something looks wrong in the robot branch itself.
> I don't see the patch in the associated branch.
> https://github.com/ovsrobot/dpdk/commits/refs/heads/series_37048/

Weird... actually - not weird.  I just checked a status report from that
week:

  ** There was another ozlabs outage, and that caused reports to be
     malformed, leading to missing results.  A recheck request should
     work, but I need to get back to the python rework to fix this.

I think this probably had an issue applying and due to a database
corruption (which I fixed) had weird behavior when applying patches.

So it's possible that this patch got caught up in the bot breakages that
happened around the beginning of Dec.

> Otoh, pushing this patch in my own repo does raise a chkincs failure.
> https://github.com/david-marchand/dpdk/actions/runs/21203869950/job/60995562483#step:19:5413

