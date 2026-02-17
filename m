Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCA9E8384F
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 04:38:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6D130402A7;
	Tue, 17 Feb 2026 05:38:08 +0100 (CET)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50]) by mails.dpdk.org (Postfix) with ESMTP id 5F21E4029D
 for <dev@dpdk.org>; Tue, 17 Feb 2026 05:38:07 +0100 (CET)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-4376de3f128so2531715f8f.0
 for <dev@dpdk.org>; Mon, 16 Feb 2026 20:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771303087;
 x=1771907887; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z5175EFRJMerZW/comB406KQPovyiZ/me7TE7EqkuVE=;
 b=hsroI6gMTzTVJrqkd0YPOVAhdQUjLqz26WRGGLlOyRXzyfBJVrD0HRtLzfJUFGa/Im
 M1Pp0xrOONfIcfie7wRONn80/h6wL4fDbhMiQ4reqhTrazur6yvnRrMdjHyTJn+j0mzN
 +4HTbBuQMgytmR+/N+mRgU9+PeGNi4e+/tJMjKaYsQb+wnIHOJYpxKfzXCV0TIP5OXTR
 aDNaOEHOg1xoW/iBNVAxbfmcd9Ztoxsk1yvbD6ZHt4B+qalkVW2NaSfF8iCIhTFKlOfd
 4y+nod7v1rHpJskNPgI4DhAIlNZPsyarzQruBIpztnVqM6Er+NlvRV+Xj2Da2N7gFIjW
 rLCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771303087; x=1771907887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=z5175EFRJMerZW/comB406KQPovyiZ/me7TE7EqkuVE=;
 b=H7WZvbiqdqSlm11ZawwkaIYECZNfkFgB9Jw/qHyA2JPshLNUZRGOfZRcTYRj3vFkha
 VQHAzTg+OG9hyI9LdTHP27m/llNloPq3iu/boAZl3o/rVW8FdfS2zLnMvZY3hGFQJM+K
 rYeDpxTyn1AeI/LDNb8PiQiwe9M+HO/us+IQ+j0JYbpwMTKt9fFmlS2OhTtlbDDaZGda
 6l1oluapTDEwWRP3UM50pBSLTNl6VbKR6Fbgxq7eF+lFAkNP/ZIndHPHlg8brbHnz+yF
 vNLWWdI3hlGC6LHaKUq0xm6FZCwZAWOl59e9EGKwXT28Pv+kKo0F2sa9XK+KBZwPRT/i
 n/Mw==
X-Gm-Message-State: AOJu0YxGexbgZfFItXKK0oFq0PqGKVpINOJ8IVJ+wlZ/7F3be3f6KPh2
 2VvsVQnSL5PM9NTd35NNSbA41/VJxnNgabAfXaHe0zxTK0wSThu87P6FUuoLq8XrQcnOBurx4x8
 3QKJktRQ=
X-Gm-Gg: AZuq6aJQ2d1VQ3dEBvmIOHnJlVrsdW/3gyFoyPo+JV4cg57mPgTxWWpeYJTmat2aGIw
 YxYfL2mVUAzL33aBvmo36M7DIGPfwEEfW+A3S1xXeixgtCn96GZ+6/L+q5jFjHrWhteNR1CuUKk
 P9eCT0T3qlA37zID6wx4Vz6o68BgWzmyKvz+95b5SZT4hBRQ89YBpFgk2FdJIvcHYJVOZgsQ2KX
 lr7pzR7IfOhUVTq28Rk803H+ZNPdXAf4omJDVOUUF1YuwI1g264hasoyJxo1HVq2P3CleEbNloh
 mGjte7WCfnDgydiHT+TZXvzH1GANcBhpsFrVFbv+4oN4KGZaDM+VfdzsS8ztOSEPCsirSkNXKYL
 pCy0YfIUoR5/gEPBewGS/VS4DjvnD1f9M4ifTYKiU603iaUTebB5i1QK6xL7law+fHVXzT9K/Gz
 0+gUX8qzuBAvto8h5++3oYkydx2g9E5OLXOZPm0QAJRHbDLo0xjYMfDEgPQtyewLFr
X-Received: by 2002:a05:6000:402b:b0:435:a194:734 with SMTP id
 ffacd0b85a97d-4379db34163mr19718304f8f.5.1771303086578; 
 Mon, 16 Feb 2026 20:38:06 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796a5ac92sm31524009f8f.1.2026.02.16.20.38.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 20:38:06 -0800 (PST)
Date: Mon, 16 Feb 2026 20:37:58 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: spinler@cesnet.cz
Cc: dev@dpdk.org
Subject: Re: [PATCH 7/7] doc/nfb: update release notes for nfb driver
Message-ID: <20260216203758.452f6cac@phoenix.local>
In-Reply-To: <20260206170435.302184-8-spinler@cesnet.cz>
References: <20260206170435.302184-1-spinler@cesnet.cz>
 <20260206170435.302184-8-spinler@cesnet.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Fri,  6 Feb 2026 18:04:35 +0100
spinler@cesnet.cz wrote:

> From: Martin Spinler <spinler@cesnet.cz>
> 
> Update the release notes for the NFB driver with Link Up / Link Down,
> RS-FEC, Rx MTU configuration and link speed status features.
> 
> Signed-off-by: Martin Spinler <spinler@cesnet.cz>
> ---
>  doc/guides/rel_notes/release_26_03.rst | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
> index 7678cf1a49..de14238b1e 100644
> --- a/doc/guides/rel_notes/release_26_03.rst
> +++ b/doc/guides/rel_notes/release_26_03.rst
> @@ -64,9 +64,10 @@ New Features
>    * The timestamp value has been updated to make it usable.
>    * The DPDK port now represents just one Ethernet port instead of all Ethernet ports on the NIC.
>    * All ports are used by default, but a subset can be selected using the ``port`` argument.
> -  * Report firmware version.
> +  * Report firmware version and correct Ethernet link speed.
>    * Common CESNET-NDK-based adapters have been added,
>      including the FB2CGHH (Silicom Denmark) and XpressSX AGI-FH400G (Reflex CES).
> +  * Added support for configuration of the RS-FEC mode, Link Up / Link Down state, and the Rx MTU.
>  

Please just update each item as part of the matching patch.
The Depends-on mechanism doesn't work well with current CI.
