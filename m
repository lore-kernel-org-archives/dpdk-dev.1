Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE2DCCF9F8
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 22:18:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C5543406BC;
	Wed,  5 Nov 2025 23:18:03 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 2E666402E6
 for <dev@dpdk.org>; Wed,  5 Nov 2025 23:18:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762381081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bJdXatMF4gqGPuuwrDjSauXYIlVv3OuRdSPEwWo3PaE=;
 b=V2QuveHnRXyaGSrBj7KKyyPrfToHEPnHDKAFpfVY9ZFhVUMHyLy6/J9D+5Kjm9cnu/NkNf
 y7vrOd5PCIGYfkMaIJqchKxWd2ZKjXfphDWMUb3goWeRVPcJWT63cCPrFbjqaqTBOF6lOv
 sBMTBlu3zvU+oHMB8DI4U0Xp2fKCW+c=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-573-mcECGTRWPjeIiT73WkP0ZQ-1; Wed,
 05 Nov 2025 17:18:00 -0500
X-MC-Unique: mcECGTRWPjeIiT73WkP0ZQ-1
X-Mimecast-MFC-AGG-ID: mcECGTRWPjeIiT73WkP0ZQ_1762381079
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6C0641956089; Wed,  5 Nov 2025 22:17:59 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.88.225])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0F0A6300018D; Wed,  5 Nov 2025 22:17:57 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org,  sivaprasad.tummala@amd.com,  Michael Santana
 <maicolgabriel@hotmail.com>
Subject: Re: [PATCH 1/2] ci: refactor build dependencies in GHA
In-Reply-To: <20251105084309.3851898-1-david.marchand@redhat.com> (David
 Marchand's message of "Wed, 5 Nov 2025 09:43:08 +0100")
References: <20251105084309.3851898-1-david.marchand@redhat.com>
Date: Wed, 05 Nov 2025 17:17:56 -0500
Message-ID: <f7t7bw4m8dn.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hA2utSvtWuBr2aOkcLCpbhgvGcY7PKe5T0TZSiJ2XfM_1762381079
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

> Move build dependencies in some multiline variable to make it easier to
> update.
> For the Fedora pipeline, use a single source of trust in the prepare
> image job.
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---

Acked-by: Aaron Conole <aconole@redhat.com>

