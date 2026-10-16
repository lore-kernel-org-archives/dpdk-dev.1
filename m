Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7701ECC6B38
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 18:18:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9BCDB4060C;
	Fri, 16 Oct 2026 20:18:28 +0200 (CEST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com
 [209.85.208.45]) by mails.dpdk.org (Postfix) with ESMTP id 8CC46402E7
 for <dev@dpdk.org>; Fri, 16 Oct 2026 20:18:27 +0200 (CEST)
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-6b1d8944cb0so209902a12.3
 for <dev@dpdk.org>; Fri, 16 Oct 2026 11:18:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792174707; cv=none;
 d=google.com; s=arc-20260327;
 b=AiXPKTGFasyIVy+QF51S0eHmKSyIAIBX03+gZ+B4wWNaJwR5bVhsIgtdxf/NgUzFAu
 QvcSpPNoooSfYkXySKCupYcdZRwJdUYhOkuwZuqepYQYVVkwESMafnnnGGrdzRZE8wIB
 IGH0g18+myYYLaEHsqrvRuG+2Regm+iRYBKJgGmHRveFCUVxWXfLc+ZbRUy11FgrPW19
 AWLYMYsLU4+AsVFGUpVc1UNv2SnQNsg6xVrR/Nexd12mHNF9a2Mz1IxB8/ickVP1Mpr2
 znQMLJWZuWEutAizfLbjPAke3zgp07w2KLHdDv+4cT0RcUKp4/VXV+WvKciSYFQ5K+DX
 Exrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3kF9sy9Q360rdNE+WXRocCKV5PLsevWUzawhGH6x/ys=;
 fh=gF5Ml7ayPE3r7WtaMJLsK8DWpdM02zekUrin3GLZ1eU=;
 b=K2S513Wq9U3aqjxhYCoSaVmR8uclf6Oa1dmvRcCI+lJg3k0J254OnejIXGdLUEyub1
 U99HC1SLRKNrDhpvPW0H57tWBxe1nPndvm1scWp/KvwdtiG0jRDckObViCgJItZyZ79/
 zVnza2VsP8tjTDNrb28D88fdx8fxHRC6E1FCKxxNj7nq4ezpmD9MHlMmylrZ5pE/tc4y
 ZRdZ68CmjRS3Dd4A6J/KK73f4Bi96/siDDKAyT9fZFEOONIVUuGFzRmvampMIq8PTxY7
 nbkvwGu5N0Ouvh0s+PAxXg8/oRNm3niGeDtQfenhuiZp09q12LbMh81s2qQvKSOvQDsI
 hOdw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792174707; x=1792779507; darn=dpdk.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3kF9sy9Q360rdNE+WXRocCKV5PLsevWUzawhGH6x/ys=;
 b=q83m68IUJX62WncRMzgJ1F7UbpCJURD+O6uZ7oKb+B7J5oSThoxpaQ0RMxhN1r26pY
 WCkqb9ZvPs9C1WyUB0erdk1fu7dfAPhGQEYniadK3bHaFctgtYb0uGl3K54aYXuX3OSx
 mUFGjOnvRNuK7OcBUSNBUavESOGVhOq9nrQSfSZTeB4YD1hOLg/QUhTO5TGc1ka84w19
 XpqD4sRu6t2Lgzqp89L+LxNoKcG+naKNQnUbGjqp4Hwya1gcocNg385l5KOW3eO5dwyR
 g8SZ6fKDehAVF6pC5+SWxENUcpSWD6CbPMBjYUcI/4QYXZo0hMoN1Pab1aWqN8awowLV
 3Cmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792174707; x=1792779507;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3kF9sy9Q360rdNE+WXRocCKV5PLsevWUzawhGH6x/ys=;
 b=ac7HfqFJJ6oK6y6pyAshmOSsc8tl5HN37+tHyuM1kAqZa18ntUPgdOjzziOM8Xq+Gh
 PadmAG/qkpaDejfZtZiY7W5SFQhJAW+JiH6Nv8hmNy9IQtNbxzaJIxktcG8FH5fAcHL1
 AXA8oXfW+AEv/ixSsHyr1wgv0mN9syMg9joViwD3dZ5xR3B57t8XmP2ZY2SXgPrMSKnf
 KS2R3n/kkptWswNWzzrykr5CWvCt5cwT+Gv3orngsUTnw9R6PJ8Ycdq9GHKF0dth9pD+
 Ft8DBw3QCxlstDHmcUHAiMfpxk0rhb20NJL6ZjLTh8JDHLJ3hJkj0DS5ryn33+73vahY
 bISA==
X-Gm-Message-State: AFq9FYKf3GbzOB33AoBiIHRWaHqi+c2T8VXwsy8qhMg0D7NhVOaxT6I1
 HdYC3OGDSrLbskRw79y8uoC5K/JaxwuhZXIvlPFZVniCMnq1KEbgnTXl5GvfvqwtIM1qzPaMRqy
 iqQnyTugYA/csCVQm2jnMAmI0XAhan2tYd3Vq1uxs
X-Gm-Gg: AYBFou14rCwKuoPsMv1XJczI+PICyJBXMs2PHqPW60XZEZFh6gLJmdN7be6XcIgXpLG
 rEZpy0u2Qq3QsGl5dIjG34d+/zxknD9OWn1sZ153ZfooE+0mw+Z41lh5rGmZG8w4cDG6r6lq0zF
 P+E6wvfsODe2gsU3KE6HLy8/7rtRvzcxM2R8Vyz1hpbL4fVnfOtN49aeCbXnUFv4nKIRNjUeu2z
 PlQqwybqp3Y0vV5hRjD8OzctHqXHuLd5XW1ro+3K0kfIxAhdmmiSL9RthohOSnaMC5m5SrZ2Msl
 LZe6nQRk6VGfWDv6Fs+bmcYBeJHsNHin/6ERLYRJ19ap9Ud6Nr4ap9ax
X-Received: by 2002:a17:907:c22:b0:c40:18cc:e710 with SMTP id
 a640c23a62f3a-c419a257d37mr52376766b.7.1792174706387; Fri, 16 Oct 2026
 11:18:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1792170902.git.tathagat.dpdk@gmail.com>
 <743453a5b3f7b1c19ee0e9d6c8882d83870cb006.1792170902.git.tathagat.dpdk@gmail.com>
In-Reply-To: <743453a5b3f7b1c19ee0e9d6c8882d83870cb006.1792170902.git.tathagat.dpdk@gmail.com>
From: Joshua Washington <joshwash@google.com>
Date: Fri, 16 Oct 2026 11:18:14 -0700
X-Gm-Features: AclHuK98b8Dag-dD8gDmFcsZq6RFhQUXVgsq6muyXG7kFxGEaNsa5jGAXSq9wtE
Message-ID: <CALuQH+UhMgBeC52f47-5+v0tXVr3B_28niWGNkGmWfwMEJtENw@mail.gmail.com>
Subject: Re: [PATCH v4 07/10] net/gve: export Tx drop counters in xstats
To: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
Cc: dev@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>,
 stable@dpdk.org, Ankit Garg <nktgrg@google.com>
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

On Fri, Oct 16, 2026 at 10:46=E2=80=AFAM Tathagat Priyadarshi
<tathagat.dpdk@gmail.com> wrote:
>
> too_many_descs is counted but missing from the Tx xstats table, so it
> cannot be read. Export it together with invalid_mbufs.
>
> Fixes: f4a70b449bfa ("net/gve: add DQO Tx descriptor limit")
> Cc: stable@dpdk.org
>
> Signed-off-by: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
Acked-by: Joshua Washington <joshwash@google.com>
> ---
>  drivers/net/gve/gve_ethdev.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/net/gve/gve_ethdev.c b/drivers/net/gve/gve_ethdev.c
> index 3c8d1a76e4..1dfbe8f396 100644
> --- a/drivers/net/gve/gve_ethdev.c
> +++ b/drivers/net/gve/gve_ethdev.c
> @@ -1042,6 +1042,8 @@ static const struct gve_xstats_name_offset tx_xstat=
s_name_offset[] =3D {
>         { "packets", TX_QUEUE_STATS_OFFSET(packets) },
>         { "bytes",   TX_QUEUE_STATS_OFFSET(bytes) },
>         { "errors",  TX_QUEUE_STATS_OFFSET(errors) },
> +       { "too_many_descs", TX_QUEUE_STATS_OFFSET(too_many_descs) },
> +       { "invalid_mbufs", TX_QUEUE_STATS_OFFSET(invalid_mbufs) },
>  };
>
>  static const struct gve_xstats_name_offset rx_xstats_name_offset[] =3D {
> --
> 2.43.0
>

Thanks!
