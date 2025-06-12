Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF04C61CE8
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Jun 2025 12:54:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6BB77410E6;
	Thu, 12 Jun 2025 14:54:45 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 22DB9410E6
 for <dev@dpdk.org>; Thu, 12 Jun 2025 14:54:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749732883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KXqwAWU657SDhiwyOsT8w4wBoZqfqoXuJro2qTc1rAE=;
 b=OpwKEL+ID+EwROOjEnygSyIFq/IcPIa0SvG2/EpwznEJhPm/HcU+uwAUundpBDy6HtQcR4
 qD1+FW40WN+gZ85RUCpp5fmB95QI0fSvj9jXG84KNCCpLk+9l24Nsy9kX9HdpA7plbfGL8
 WIM4zVQOIpAoEdvPxpM0BdYMYmPpo0E=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-353-jodRvgYrNv2Sq2gayfWOTg-1; Thu,
 12 Jun 2025 08:54:40 -0400
X-MC-Unique: jodRvgYrNv2Sq2gayfWOTg-1
X-Mimecast-MFC-AGG-ID: jodRvgYrNv2Sq2gayfWOTg_1749732879
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2CD671955F66; Thu, 12 Jun 2025 12:54:39 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.64.166])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8D049195609D; Thu, 12 Jun 2025 12:54:37 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org,  thomas@monjalon.net,  Michael Santana
 <maicolgabriel@hotmail.com>
Subject: Re: [PATCH 1/2] ci: treat warning as error for MSVC builds in GHA
In-Reply-To: <20250610083643.8466-1-david.marchand@redhat.com> (David
 Marchand's message of "Tue, 10 Jun 2025 10:36:41 +0200")
References: <20250610083643.8466-1-david.marchand@redhat.com>
Date: Thu, 12 Jun 2025 08:54:35 -0400
Message-ID: <f7t34c5t910.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3J26bmPvVS8s7EJenRzHD1R4HMfOwVwH34jOclfcDZQ_1749732879
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

> Some trivial builds warnings with MSVC were missed as those were not
> treated as errors.
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---

Acked-by: Aaron Conole <aconole@redhat.com>

>  .github/workflows/build.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/.github/workflows/build.yml b/.github/workflows/build.yml
> index 1e289979e3..e5f17ef6ac 100644
> --- a/.github/workflows/build.yml
> +++ b/.github/workflows/build.yml
> @@ -198,7 +198,7 @@ jobs:
>        shell: cmd
>        run: |
>          call "C:\Program Files\Microsoft Visual Studio\2022\Enterprise\Common7\Tools\VsDevCmd.bat" -host_arch=amd64 -arch=amd64
> -        meson setup -Denable_stdatomic=true build
> +        meson setup -Denable_stdatomic=true -Dwerror=true build
>      - name: Build
>        shell: cmd
>        run: |

