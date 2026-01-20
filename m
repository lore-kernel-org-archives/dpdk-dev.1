Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AADCD2ECF7
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 13:19:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 57BC840E30;
	Tue, 20 Jan 2026 14:19:25 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 8D9CB4013F
 for <dev@dpdk.org>; Tue, 20 Jan 2026 14:19:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768915163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vgGQDtUVuSvVtGPpCbklWiChzK/Kk+6GQiLFoWEQh18=;
 b=Icyn162dd09m1vbjE/QmC3KpEBxbe6VccDHVmOxrcf62dfFUq+S5NhNkmUWlqSCmDhQep0
 22iGcM8GhOtDAz5+mrGDW9l1333+GaDKSzrARMoks1AZJhQdq7uSjVL3oo0nj9pFAG8WRb
 VkdOVroklgvT84sHsUXva3JWHCOo1Zg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-311-jgrLgg8uMfO0PVgtc2NjVA-1; Tue,
 20 Jan 2026 08:19:17 -0500
X-MC-Unique: jgrLgg8uMfO0PVgtc2NjVA-1
X-Mimecast-MFC-AGG-ID: jgrLgg8uMfO0PVgtc2NjVA_1768915156
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3D1D219560AD; Tue, 20 Jan 2026 13:19:16 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.64.171])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 14B8319560AB; Tue, 20 Jan 2026 13:19:14 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Patrick Robb <probb@iol.unh.edu>, ci@dpdk.org
Subject: Re: [PATCH v2] ci: improve logging of unit tests runs
In-Reply-To: <20260119115607.225929-1-bruce.richardson@intel.com> (Bruce
 Richardson's message of "Mon, 19 Jan 2026 11:56:07 +0000")
References: <20260119104147.219027-1-bruce.richardson@intel.com>
 <20260119115607.225929-1-bruce.richardson@intel.com>
Date: Tue, 20 Jan 2026 08:19:13 -0500
Message-ID: <f7ttswgxvzi.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1Fa43R-Z7OULLu3mbyr82qi4HkCqkmuac9v8ZgoSpjw_1768915156
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

Bruce Richardson <bruce.richardson@intel.com> writes:

> To help track down issues reported by CI test runs, add some additional
> meson flags to the run of the fast-tests:
>
> --no-stdsplit:
>   keep the stdout and stderr output interleaved, rather
>   than separated in the logs, to make following what is happening during
>   a test run easier.
> --print-errorlogs:
>   when an error with a unit test does occur, output to the terminal the
>   last N lines of output. This allows us to see inline what may have
>   failed without always needing to check log files.
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
> V2: Drop max-lines flag, since it's only introduced in very recent meson
>     versions.
> ---

Thanks for working on this.  I guess when we bump our meson support
version we could re-introduce the max-lines flag (looks like it was
added in 1.5.0 based on reading the notes).

Acked-by: Aaron Conole <aconole@redhat.com>

CC'ing Patrick and the CI list - just in case any of the labs have any
special processing when they pull error logs.

