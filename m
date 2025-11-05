Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADA1CCFA0D
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 22:19:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C5AD740DCD;
	Wed,  5 Nov 2025 23:19:33 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 57DDB402E6
 for <dev@dpdk.org>; Wed,  5 Nov 2025 23:19:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762381171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xoO9HOe9Kj/d0u4YplSNssMFFLYmIKZey+DaNFEHOYE=;
 b=B7z1eNIM6CGkh4YcptOP6sBkwHA1WgXpmtanMJr8wBIWJcq56p5PtVz8dJ7+PgPLTg/ouh
 u9blAPrBJVaK66Vl92qhJOTROSTGbtl7uvvzXKrgNK2w8a5LMl3/o0CpVpGkC2Ve9WKtw5
 dsOXgkpwugkNOq6oSmDPXvtvL6JVvuU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-93-ZugukXNBPlWgzqsS9YBxxQ-1; Wed,
 05 Nov 2025 17:19:30 -0500
X-MC-Unique: ZugukXNBPlWgzqsS9YBxxQ-1
X-Mimecast-MFC-AGG-ID: ZugukXNBPlWgzqsS9YBxxQ_1762381169
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3DAC4195608E; Wed,  5 Nov 2025 22:19:29 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.88.225])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8D089180049F; Wed,  5 Nov 2025 22:19:27 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org,  sivaprasad.tummala@amd.com,  Michael Santana
 <maicolgabriel@hotmail.com>
Subject: Re: [PATCH 2/2] ci: add dependency in GHA for AMD uncore power driver
In-Reply-To: <20251105084309.3851898-2-david.marchand@redhat.com> (David
 Marchand's message of "Wed, 5 Nov 2025 09:43:09 +0100")
References: <20251105084309.3851898-1-david.marchand@redhat.com>
 <20251105084309.3851898-2-david.marchand@redhat.com>
Date: Wed, 05 Nov 2025 17:19:25 -0500
Message-ID: <f7t346sm8b6.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _KnxI2b3P9qjsvFbnr5MG0_HSO5edVsP_lIuw0ssnVg_1762381169
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

> Adding only for Fedora, as I could not find the library for Ubuntu.
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---

Agreed - I didn't see anything (well, there are ubuntu repos that mirror
the EPEL repositories, which is strange to see - but I don't think
they're installable).

Acked-by: Aaron Conole <aconole@redhat.com>

