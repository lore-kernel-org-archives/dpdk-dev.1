Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B897C19F32
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Mar 2025 14:59:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A1C12402A4;
	Wed,  5 Mar 2025 15:59:24 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 7E02840275
 for <dev@dpdk.org>; Wed,  5 Mar 2025 15:59:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741186763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7KLIjA3GaoEzgByJWEKVLQG5G9EtGPsB9CDyPnsxuak=;
 b=U3/jZZkFqSyvxec3j0vLbhq2HQv+1v50UPWYX/6mSADlk76FqDmiD9wySNrsyWq6USdE16
 3ZkPgCDq/ghZyYEGPXMSh5x3DYF8IV5wfoVOq8YPoZ/X9D5leZPlxS4KxCKOxrP3GzJIiQ
 Vq0z6ohscvq2ewjQeA0wIvCrw0ye4Vw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-qeYdVBP3NlS6WbWHbrt9aA-1; Wed,
 05 Mar 2025 09:59:19 -0500
X-MC-Unique: qeYdVBP3NlS6WbWHbrt9aA-1
X-Mimecast-MFC-AGG-ID: qeYdVBP3NlS6WbWHbrt9aA_1741186759
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F3F5218001D3; Wed,  5 Mar 2025 14:59:18 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.81.152])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7AF0E1800255; Wed,  5 Mar 2025 14:59:17 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org,  stable@dpdk.org,  Michael Santana
 <maicolgabriel@hotmail.com>
Subject: Re: [PATCH] ci: point at GitHub mirror.
In-Reply-To: <20250304155036.383468-1-david.marchand@redhat.com> (David
 Marchand's message of "Tue, 4 Mar 2025 16:50:36 +0100")
References: <20250304155036.383468-1-david.marchand@redhat.com>
Date: Wed, 05 Mar 2025 09:59:10 -0500
Message-ID: <f7tsenr4j7l.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: i_dZ09cLZO0_toaP3vlMu9XzLNO8y-OcrnroNsx6fbA_1741186759
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

> We face some random failures accessing dpdk.org git when running GHA.
> Point at GitHub hosted mirror.
>
> Cc: stable@dpdk.org
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---

Thanks - this change makes a lot of sense to me.  I was going to say we
can use the ``GITHUB_REPOSITORY`` variable, but the problem with that is
that it will pull references to the local users repo instead.  I guess
there isn't actually a good reference to a 'source of truth' that is
predefined.

Acked-by: Aaron Conole <aconole@redhat.com>

>  .github/workflows/build.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/.github/workflows/build.yml b/.github/workflows/build.yml
> index 183b0b1999..e98a60a852 100644
> --- a/.github/workflows/build.yml
> +++ b/.github/workflows/build.yml
> @@ -11,7 +11,7 @@ defaults:
>  
>  env:
>    REF_GIT_BRANCH: main
> -  REF_GIT_REPO: https://dpdk.org/git/dpdk
> +  REF_GIT_REPO: https://github.com/DPDK/dpdk
>    REF_GIT_TAG: v24.11
>  
>  jobs:

