Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27218CA5FA3
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Sep 2026 19:45:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E8EB94060A;
	Mon, 28 Sep 2026 21:45:55 +0200 (CEST)
Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com
 [74.125.230.205])
 by mails.dpdk.org (Postfix) with ESMTP id 240A3402F0
 for <dev@dpdk.org>; Mon, 28 Sep 2026 21:45:55 +0200 (CEST)
Received: by mail-qk2-f13.google.com with SMTP id
 af79cd13be357-93a2a8c29c4so304500285a.3
 for <dev@dpdk.org>; Mon, 28 Sep 2026 12:45:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790624754; cv=none;
 d=google.com; s=arc-20260327;
 b=c95tGs3INdNHwBDvVGx8NhgfOPdGjuxftlWc1qLvx7QZb9ne8FBmRRTKyW9/6c39Fh
 QlNyS12hF7W25adDBe/RWMAZewWAbHKSU3buQuWwpa/ZufCQb0q6CX+rvQWqdVkbQVo6
 UFvTJjUR99slMliU6/SVlDfXBPfO00l6PYfxBm7uGsAynrDZyqdHwpKhIJ1fOelkCm1f
 7RBovwYJnumX7ta9FuZbOyF3EQJ/JYlNOEVeKt79vENGxKbJiquzCC7YE9td4eAipFII
 lCBfkVLN3OIxnLQPAUSxV02oLyXgOz7RYePznA9vcrzI4Wi2nsad+6yF2MQO/XGe+r6y
 4Qdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=aJ9OohTuCuAGXZGh8oGnS29NidgsBju4E2TZr9xj8Ls=;
 fh=XUKkYDOvKLfBvX2ondmaBwSE3vUtWra43Hvg9mKPYH0=;
 b=EcfTpK5oQ+XJ99EgtL4gw8sP0RMogvUetQHCH9CgFARfML1lkGZ61mxvx5yIZZ+Kgg
 L6V08Nfpf/cc0gP06BDTRrMhsxlt+j86m26rabsCcD95Sqkvvbq6/dHoLwmtMn3xpmtS
 qDXb5FdcOchrHfEQD5mM6iTbCxm9K3TzmxW66e/2xlPTgUoGFevYnEYUaXAxY4x0YDME
 7cZhP37NtmuNAVT/Rgi+KVtb5Hxl2RHtlI33pJCZp58dFQvu5d7HhSrJLY+uJHBs56YI
 3G0DFJHJWHp/GMb4gLKBXX1Ah0jDEbstv6T6ykgNrwK0Xy38NA2hfna+XRQUAlge8Iq8
 6Y0Q==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1790624754; x=1791229554; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=aJ9OohTuCuAGXZGh8oGnS29NidgsBju4E2TZr9xj8Ls=;
 b=HSXaqOcR5iEvhZONC7uBEj+yEUjqK0lU9pnX+SJK8zwJJUuhdls9PooI+Yxa5UIGEw
 1P2X52Chdr8zobluf1NPBa+5v1qAB4CmnqOYseMiksLRIR288vnxtjOy4/owdyKXfuZZ
 g3B0vA5QKoUd9kmvY7b/KnBc5O5CgQAz6nSFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790624754; x=1791229554;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=aJ9OohTuCuAGXZGh8oGnS29NidgsBju4E2TZr9xj8Ls=;
 b=Hjnq/ebBTLou6zo1UrM/wBgaWbKaNrrMdVrpJ0ktEALr+DsqvdLXA4O3G7ZlBl5BJW
 qtT/rcNresxNQ1BWqBvGAEslXIu9LVvQa7zYbDU+OyM7HYD5fQp68KtNlZA5Yaol0jQH
 vRACS7UE6FgdsKhdarWuPC4ExtLgJ8lrQ+45TilEvxXfzjdMqJ9j3H8tNUq0mh0iiSzJ
 JgUrpJtsxue92aW+RPcqz8ep0UoBngPnq887J+G7Hr24WwnflYv1e0HNv1zpHVdbxXqJ
 A0tUmp0FZM1rtj966oQ7pjxclDnW3es5YAwOA4yZIvEBhRwOhuZp1FFEOiowojWcAZ2N
 LzEQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxL67980NKieUgWu/E/G94OmKUXw1b9wzizfZgDAsATmw8Foav6kBAeHF1Kwu5S9jEs6LA=@dpdk.org
X-Gm-Message-State: AFuF++mn/CAQvENbSF//aGMYvSwgASA65F7fMfsogBIxQxIHgNsDzRF4
 lGt+V1XPVirr/3FIxSJe8NjhyoS4LoFsd4zAoMM+2asSKE/dpXSs8invOz3HDf1pL7BIYf2OExT
 Ysf/giYrJs2M44s9UKxfthpyyrSyXo8K2nwr5EhaoAA==
X-Gm-Gg: AYBFou1kMZ8OZIpYFdQ1veoESOZDdUXbZAUOdnRdk7tRIsNDLSmmH4wM1VYdwgncZPe
 Hgcay2avhvnrAVC+FKZWp4YV5qqYxj1SA3ndYncnwaZ695BuKgSBZxBNlbVCi8X7cM2JYLhPmab
 nPovdTqGRC1s6uvcUEn0SD3slY3Xjm2x9ixpesEnjh4MJkm7HLPUZrIOOZgBkES9D8sFpjMB3PK
 SM1upGOTlEQNATJ0LXfFPEg57/7sfc2CdfGN1lnWrV7JtzH7rYg19B14zB/AHYTi2k0Gx0KOF1V
 HyMzYFmZsmVvA6nduI6XSPw9SkI7SKptVbaKSPhYjTxpJdKe8CsB+WzVkoEyGWYqu8DAGg==
X-Received: by 2002:a05:620a:a41b:20b0:93c:6f06:8f7 with SMTP id
 af79cd13be357-93c6f060a36mr721231985a.36.1790624754376; Mon, 28 Sep 2026
 12:45:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260812194428.296334-1-knimoji@iol.unh.edu>
In-Reply-To: <20260812194428.296334-1-knimoji@iol.unh.edu>
From: Andrew Bailey <abailey@iol.unh.edu>
Date: Mon, 28 Sep 2026 15:45:43 -0400
X-Gm-Features: AclHuK9Chpcyu0Ye9yi-Kn8xx3WNGfvo_4bbTVoFGTyzkslFR--JRw_G3-ntvhc
Message-ID: <CABJ3N2XUSYBgP2-chFkrLMZv12otVfMhYzkBFb52uPuPWU4pSg@mail.gmail.com>
Subject: Re: [RFC PATCH] dts: restore unbinded ports to initial state
To: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Cc: luca.vizzarro@arm.com, patrickrobb1997@gmail.com, dev@dpdk.org, 
 dladd@iol.unh.edu, lylavoie@iol.unh.edu
Content-Type: multipart/alternative; boundary="000000000000693612065c90500e"
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

--000000000000693612065c90500e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 3:44=E2=80=AFPM Koushik Bhargav Nimoji <knimoji@iol=
.unh.edu>
wrote:

> Once DTS completes execution, it re-binds ports to the drivers
> they were initially bound to. However, when a port was not bound
> to any drivers, it would raise an error when the bind command was
> run. This patch resolves this issue, and properly unbinds a driver
> if it was unbound before DTS execution began.
>
> Signed-off-by: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
> ---
>

Missing "Bugzilla:" Tag

Just need to add the Bugzilla tag so it can be backported, Thanks Koushik.

Reviewed-by: Andrew Bailey <abailey@iol.unh.edu>

--000000000000693612065c90500e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Aug 12,=
 2026 at 3:44=E2=80=AFPM Koushik Bhargav Nimoji &lt;<a href=3D"mailto:knimo=
ji@iol.unh.edu">knimoji@iol.unh.edu</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">Once DTS completes execution, it re-bind=
s ports to the drivers<br>
they were initially bound to. However, when a port was not bound<br>
to any drivers, it would raise an error when the bind command was<br>
run. This patch resolves this issue, and properly unbinds a driver<br>
if it was unbound before DTS execution began.<br>
<br>
Signed-off-by: Koushik Bhargav Nimoji &lt;<a href=3D"mailto:knimoji@iol.unh=
.edu" target=3D"_blank">knimoji@iol.unh.edu</a>&gt;<br>
---<br></blockquote><div><br>Missing &quot;Bugzilla:&quot; Tag<br><br>Just =
need to add the Bugzilla tag so it can be backported, Thanks Koushik.<br><b=
r>Reviewed-by: Andrew Bailey &lt;<a href=3D"mailto:abailey@iol.unh.edu">aba=
iley@iol.unh.edu</a>&gt;</div></div></div>

--000000000000693612065c90500e--
