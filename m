Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7E9C88E75
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 15:08:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 203CB40B91;
	Tue, 15 Sep 2026 17:08:44 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 6F6C240A6B
 for <dev@dpdk.org>; Tue, 15 Sep 2026 17:08:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789484921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OherCW1Z4qT6+eBP0GHIEbMzDLAeKm7llNcrtPIfiaA=;
 b=IOjyXHg+0EqErjhqet4kiqX8faN3buqgSNqxsa4T+JD600vUvw13T58N7epwSZwh1RlZJO
 QviCKlEY3deSdHrjjFngPPzZ7ESLx5/gRaKyw2EqVE9X/59861EoS9NtWkUd9af3tiHABP
 Q3dW4FkwuA9GtH8Urti42HYmJDbXaAM=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-E5HjNl5fMNqcVzeBSvN3RQ-1; Tue, 15 Sep 2026 11:08:40 -0400
X-MC-Unique: E5HjNl5fMNqcVzeBSvN3RQ-1
X-Mimecast-MFC-AGG-ID: E5HjNl5fMNqcVzeBSvN3RQ_1789484919
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-3a27721662eso19478161fa.1
 for <dev@dpdk.org>; Tue, 15 Sep 2026 08:08:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789484919; x=1790089719;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=OherCW1Z4qT6+eBP0GHIEbMzDLAeKm7llNcrtPIfiaA=;
 b=eNpRDmTa+TT+GjDb4faULUSI/DUfA4IRi6mLpNPT7KITFVsdCCGPJqgOBb5D5JTBEx
 Ov1W7oQaY4AXGGFHd/44fBUDoTY4BsqQk+69T503tCVn+jtrQ7dwAQFkUCDOmQT1ktDn
 Ph+g7M2RKUEUfGmkjZquelPTcaAjEZimH4g723uAHvm4rgRKYbLzx31LUYb7f0ye67B6
 ngT9smgm7DJ+qp+sdXz8P/PRawqS2tnrE1mnz8Ls938T9Cy/RW3xGccdLll1dvhnHn7l
 G2FMUyfhL0fdVF8ki5BMgnYfFzt/2Pksrr22aUbXkkY4EuYREnXH1VF+4VfMM15J932S
 8wZw==
X-Gm-Message-State: AFuF++n6qbd+FWwBzNbmB9XuWx4Tg7DPZCj70OZAFYPQ3xwxWNnlKqnz
 XnL6gzEs8PizXKtYZjskdwUHQTOh5MyqMltSdLOiK3727gi8b5tdxC7qX1amhpK56DRd/e6x+5A
 NwQGjF1246W8si3KsPn0NIrMcAihdZo7rhFCJrcMq+1j5Ytv8r6j6cWVchu2EUnZ85nYVM6VyY4
 hSUWMEsGHPGCKXhF+eCp8izLympYw=
X-Gm-Gg: AYBFou1moSiTEy77Lh8ZqrPmptyGIJIgin1M8+yAIaehz43ev4DGDbE/6Wvuz+esvK6
 lIVRG9KYY+Lty87YwekwMApiJtXXM6UMS1LSlQ+VmMi6xkH2FkxnGt14VvUJXuL60B45xQM3YZg
 gREFu5BqWsl4jYSFTnXbdzzctKpFzVJq6lAYGaVVbZPrsqf3OdxWm7S0WpOD1xq7WBB9tYq8Hgz
 rBkxC9OWCVKh2fRouKWuqkMQF3EwXFI0OP8v0fmK4jRx6qo
X-Received: by 2002:a05:651c:a213:10b0:3a3:749e:31a1 with SMTP id
 38308e7fff4ca-3a5c898bedfmr9215311fa.21.1789484918733; 
 Tue, 15 Sep 2026 08:08:38 -0700 (PDT)
X-Received: by 2002:a05:651c:a213:10b0:3a3:749e:31a1 with SMTP id
 38308e7fff4ca-3a5c898bedfmr9215291fa.21.1789484918261; Tue, 15 Sep 2026
 08:08:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260912063319.4117869-1-stephen@networkplumber.org>
 <20260914173700.2795983-1-stephen@networkplumber.org>
In-Reply-To: <20260914173700.2795983-1-stephen@networkplumber.org>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 15 Sep 2026 17:08:25 +0200
X-Gm-Features: AcwNN1V0PfereiCKT70_sj1TchlGClCpw3qiFl4Frpox9jMOOE1_Mz3hVfMbvqQ
Message-ID: <CAJFAV8znaZ73Vw=frtz-Cz5S7_DQOHhVem-jmRbAy5CunoTFHQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] consolidate sysfs access
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oDDNHBxBy0ZIxGZ3Vv-uryJ7PjJwi7NkWpDouWGTq5U_1789484919
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Mon, 14 Sept 2026 at 19:37, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> After reviewing lots of drivers and seeing sloppy string handling
> resorted to AI assistance to unify and consolidate the parsing
> of sysfs values. Many drivers open code this with similar pattern
> but lacked any coherent error handling. The kernel API is
> consistent and won't give bad data, but it make sense to
> check for garbage.
>
> Add one set of routines in EAL that build the path from a printf
> style format and convert with strtoul()/strtol(), then convert the
> existing callers.
>
> Since the new routines are Linux only, a driver that uses sysfs while
> advertising support on FreeBSD or Windows now fails to link. Two such
> cases turned up and are fixed here: the eal_fs test and common/ionic.

You can move the new header in lib/eal/linux/include/ and remove the
#ifdef LINUX guards.

>
> Note: existing eal_parse_sysfs_value() goes away with this.
> It was exported as a stable symbol, which was a mistake:
> the eal_ prefix and the private eal_filesystem.h both say it is internal,
> and nothing outside the tree should have been calling it.

I agree.

> The new rte_sysfs_parse_XXX routines are exported, but marked
> as internal use only.
>
> v3 - fix doxygen comments

I'll try to review soon, after the VFIO series.


-- 
David Marchand

