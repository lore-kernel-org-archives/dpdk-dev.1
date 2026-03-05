Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5145FF30955
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Mar 2026 12:20:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4733A406B6;
	Thu,  5 Mar 2026 13:20:10 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id A3E14402CC
 for <dev@dpdk.org>; Thu,  5 Mar 2026 13:20:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772713208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZXnDqfi/vKZEjpvUHWDSHVkBQobPDNCyIJ07J36/wZ8=;
 b=BwxJLjHXJgib4ol+fDRc2+6KncvI0ag3PT7YGqHIPNgOrluyHJR7ehpRnTcBoUC3bAcuug
 DYQksaHsmGVq7odFNjAF6XTTYmzOjXDnoA6G1RcO8SJKHAtKCF5i+bjpzadVsaK+XtJUcG
 Mlcr6Omer94igj+uJi6euGgGMB7Iics=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-jFsdJQa_NoaS16DK6zL-XA-1; Thu, 05 Mar 2026 07:20:06 -0500
X-MC-Unique: jFsdJQa_NoaS16DK6zL-XA-1
X-Mimecast-MFC-AGG-ID: jFsdJQa_NoaS16DK6zL-XA_1772713205
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-38a34c834c0so3663651fa.2
 for <dev@dpdk.org>; Thu, 05 Mar 2026 04:20:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772713205; x=1773318005;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZXnDqfi/vKZEjpvUHWDSHVkBQobPDNCyIJ07J36/wZ8=;
 b=uNCUaOiOgmNTE75wo//I4KUr/i+mDc3pSyksOAGIytwTOPHvXCgX4kjL3qpl47BTYi
 6cu5aLWAcAIjyaYKxjkdAGGtmia0XhLEqbHr9YirVYDMuxUlVhS+nAUgSsnh2d5+A/DE
 hfPHRGSWO2YCNLhnDQWl+hRUZ66S0PgDt/CA/KHUOowDlPR8/7OFJ3rcCgVqiWscnTYU
 YuyUE8a/+f90VIk8yUap8GbjcurF7PiJDXQWxYi5ZfPe2GW4Ovd29T11GqgAbCQAmvgt
 doKClD4bVFZm8Jd7FP9mgGLHBKsGQqwf7emzoxO8IFYBhrh9CbGMGtqvCAMPFRvkHwHG
 63LA==
X-Gm-Message-State: AOJu0Yy8pdeFpcTgOPBHwkdBnI8k7l35ejM79YV04NqIlDrE1Yq4q486
 YIOAdI7yx+haEKESILgtNF/+0KK3qdz9FehM2F9wxIRYFHB3s253oZ2cfZmA1KtgdnvP7f+ppaN
 eLHiWdaLzrA6laG/0lEbTfNXI/67gT72yBtssMKRijKF0vl6yiM9jLrKrWtbF4NwxkaZBYbTjA7
 XgygCGNGIVQ0auX5hwacY=
X-Gm-Gg: ATEYQzz8NIRtxw9NEN7VpQQlgnIDXqJkQlk3Pelipnr9h24UoVF4G9EE9AzVXMctict
 n8BVnlqaeVu30PSLFf5ad71myF6LlxuB4dTHv0WDULXUXpKPjY3xTc6bVhKM/yThAnPAOKKMcb6
 pH1VZvAKP7wrqYaPZOAOZekn28OSp0zz2xa9YdyTSEiJBKeZyF4fdpUahLFnk7OcVSj8ynfKo8Z
 NrOYGd/REPL2iJhbCsFM8ywne/ZTHYf1Nzv68HM/iMPyNj+iyU/KyCyS2W2gAXpAy+8CQ==
X-Received: by 2002:a2e:8a96:0:b0:386:fa6b:44e0 with SMTP id
 38308e7fff4ca-38a2c597bf5mr32962021fa.10.1772713205158; 
 Thu, 05 Mar 2026 04:20:05 -0800 (PST)
X-Received: by 2002:a2e:8a96:0:b0:386:fa6b:44e0 with SMTP id
 38308e7fff4ca-38a2c597bf5mr32961861fa.10.1772713204668; Thu, 05 Mar 2026
 04:20:04 -0800 (PST)
MIME-Version: 1.0
References: <20260220143933.2553112-1-bruce.richardson@intel.com>
 <20260227130245.194400-1-bruce.richardson@intel.com>
In-Reply-To: <20260227130245.194400-1-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 5 Mar 2026 13:19:52 +0100
X-Gm-Features: AaiRm53PqCB8Gz6RvjTICZFF26zxk_dToqM9bfApvh4C3obtaQXp_hC9N0s-2qE
Message-ID: <CAJFAV8wP2ZcZHctx8RgmPzch72JrEEHGhiaz+_LnyND6yVPBZQ@mail.gmail.com>
Subject: Re: [PATCH v3] hash: fix overflow of 32-bit offsets
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, stable@dpdk.org,
 =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: piSkY0baKyi_HjB4S0upH3OmWwmGyG_0HRVsS1ihp3c_1772713205
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, 27 Feb 2026 at 14:03, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> When computing the offset inside the overall hash structure by adding an
> offset to a base pointer, the offset was generally calculated by
> multiplying two 32-bit values, which could then overflow. Prevent
> overflow by using (size_t) casts on the elements being multiplied to
> ensure they are 64-bit on 64-bit systems.
>
> Fixes: b26473ff8f4a ("hash: add reset function")
> Fixes: 406da3dfb3b5 ("hash: move duplicated code into functions")
> Fixes: 9eca8bd7a61c ("hash: separate lock-free and r/w lock lookup")
> Fixes: 4d9ca3ed2133 ("hash: use ordered loads only if signature matches")
> Fixes: 769b2de7fb52 ("hash: implement RCU resources reclamation")
> Fixes: e605a1d36ca7 ("hash: add lock-free r/w concurrency")
> Fixes: 6dc34e0afe7a ("hash: retrieve a key given its position")
> Fixes: f9edbc9bb6bc ("hash: add iterate function")
> Fixes: 75706568a7eb ("hash: add extendable bucket feature")
> Cc: stable@dpdk.org
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> Acked-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>

Applied, thanks.


--=20
David Marchand

