Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B4D6F9D0F6
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Apr 2026 20:07:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8E0014028F;
	Tue, 14 Apr 2026 22:07:30 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 0C0174028D
 for <dev@dpdk.org>; Tue, 14 Apr 2026 22:07:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776197248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Hgyvy0DfdgO9E/s8FB6foT4HACNJiYxegfM4YArrg0M=;
 b=gnMKxNb5sk9dBC7/7FTLHlPgxLrjkxhP5bjh7IZ3jzAQkFat8JPzXdMMLYgPPf8ISbYXS6
 06BqsxUf7NzicF8Bp7AON/q3Axm87YAV26QFh0DtN6wIueEt+q5YB7097eBYGZHSOz+F/G
 9Y6H+SEPj9YVjzIjIk53C8aqStv19AI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-TmzQ43uFPnK0G0J7hp2FiQ-1; Tue,
 14 Apr 2026 16:07:22 -0400
X-MC-Unique: TmzQ43uFPnK0G0J7hp2FiQ-1
X-Mimecast-MFC-AGG-ID: TmzQ43uFPnK0G0J7hp2FiQ_1776197241
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E9CE81954205; Tue, 14 Apr 2026 20:07:20 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.81.47])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1E0483000C21; Tue, 14 Apr 2026 20:07:19 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org,  Thomas Monjalon <thomas@monjalon.net>
Subject: Re: [PATCH v13 6/6] MAINTAINERS: add section for AI review tools
In-Reply-To: <20260402194618.134002-7-stephen@networkplumber.org> (Stephen
 Hemminger's message of "Thu, 2 Apr 2026 12:44:36 -0700")
References: <20260126184205.104629-1-stephen@networkplumber.org>
 <20260402194618.134002-1-stephen@networkplumber.org>
 <20260402194618.134002-7-stephen@networkplumber.org>
Date: Tue, 14 Apr 2026 16:07:18 -0400
Message-ID: <f7to6jl8fwp.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PCKXLdCJmhaygofKuyDXWzGvhRk5iyrNj2vP6Ao8wcc_1776197241
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

Stephen Hemminger <stephen@networkplumber.org> writes:

> Add maintainer entries for the AI-assisted code review tooling:
> AGENTS.md, analyze-patch.py, compare-reviews.sh, and
> review-doc.py.
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

Depending on the result of previous comments (if we merge the doc review
script) - that will change the exact files in the AI review tools
section.

Acked-by: Aaron Conole <aconole@redhat.com>

>  MAINTAINERS                            | 8 ++++++++
>  doc/guides/rel_notes/release_26_07.rst | 5 +++++
>  2 files changed, 13 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0f5539f851..c052b6c203 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -109,6 +109,14 @@ F: license/
>  F: .editorconfig
>  F: .mailmap
>  
> +AI review tools
> +M: Stephen Hemminger <stephen@networkplumber.org>
> +M: Aaron Conole <aconole@redhat.com>
> +F: AGENTS.md
> +F: devtools/analyze-patch.py
> +F: devtools/compare-reviews.sh
> +F: devtools/review-doc.py
> +
>  Linux kernel uAPI headers
>  M: Maxime Coquelin <maxime.coquelin@redhat.com>
>  F: devtools/linux-uapi.sh
> diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
> index 060b26ff61..aa9e1e962c 100644
> --- a/doc/guides/rel_notes/release_26_07.rst
> +++ b/doc/guides/rel_notes/release_26_07.rst
> @@ -55,6 +55,11 @@ New Features
>       Also, make sure to start the actual text at the margin.
>       =======================================================
>  
> +* **Added scripts and prompts for AI review.**
> +
> +  Added AGENTS.md file for AI review and supporting scripts to analyze
> +  patches and review documentation.
> +
>  
>  Removed Items
>  -------------

