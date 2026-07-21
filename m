Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C13C4451C
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Jul 2026 10:24:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F94E4064A;
	Tue, 21 Jul 2026 12:24:36 +0200 (CEST)
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com
 [209.85.160.49]) by mails.dpdk.org (Postfix) with ESMTP id 895CB40687
 for <dev@dpdk.org>; Tue, 21 Jul 2026 12:24:34 +0200 (CEST)
Received: by mail-oa1-f49.google.com with SMTP id
 586e51a60fabf-43bf9548df4so5706907fac.0
 for <dev@dpdk.org>; Tue, 21 Jul 2026 03:24:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784629474; cv=none;
 d=google.com; s=arc-20260327;
 b=LofeB9LfAmU/laOUnweb2Sypzdkuxfg/JN575RSKAFdCHTFWohwerYwx08fHc664fX
 hTN+1U+ZtOJhIoAwajd8tWMP78aMUmV+JUn56VTyFaueaFeotCMXblnrjdEt/x2Z3v2e
 JSt/T+3wIUvO94hdKJdsCQiUTTSaYgC9hMrrnqGa5q24Wz25ebOPf1dpxKRy+dg0dLZT
 H6mDaAt8l7q+MsjXFd/q/NL27YSZxmmKqazG2UAardxAF3Eo7TIR2UlleGG1eDoHQKub
 +PgEQEZi/Oe6edQXQzwA50SMNJfu5ZxYLFmxy6GhIcOOUxqKIVjcOc5Xaq5tQMUT8cTm
 wNkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LNIPg2dSS4jXhhK8MqyiNnYyZwPU/+lIyDmHUjXxBN0=;
 fh=AlWrETRXsmxQwM6CgsTmxQ1VLa6tr3MyI/1QgI7v9As=;
 b=g7X8HpcgbHviKE+6xOCQPhWtKt2C7LIFSvBl0058nQmB5LSETrnM0I57Xs/5kWTSeI
 EEezBThhJMWIssnsZ4xj2YCYgGzfjhIscoBn2klgusySHllBklIkPXF1pEex0lm5m2BG
 15Iahi4UAFjNEsIL5Zfw6sYQTM8uYdjWPSgq6WscVcTAEpYV8bHTNGvi4y5ro/UY+bRe
 rYed20ZwJ0hoRbdqDCc41qm3T6RYV4fTe/kB6/RbUxZhMdOf2zzxBOkt26O/4Uf65fQu
 kr5BaMDa8bLnVrBoBvX9jfgOA/k8cwBYdFWymotxvH8SS1eKYh4dOngYk7xYKJu+vFtx
 G9gg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784629474; x=1785234274; darn=dpdk.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LNIPg2dSS4jXhhK8MqyiNnYyZwPU/+lIyDmHUjXxBN0=;
 b=B9xsuRHZj57SrKEdG/Ini1meygNuejmz88KEQTO/TpsA8hGDHeWD9usDgeFHu58IyU
 eqf6QoM91aTHoa3BpDEcIdG6NqZexaaEvEkGH/oIHVrUGPcKQOvHS6bK3hQgCAZdYCQ7
 PXBPGn65E5R4gJ559YeajTgUD6PdqWPj+UyPtiIoSdGDDre7d3IiYiURD5GUNfFpC2JO
 GA5J96rbepgntAXNXPniJSkClBfrOMy8OQoDOZfLRwEYYWK2wsb9j2ZD3Cirglmcsh6T
 uY81Gn6Kc9uIbkSUZJPayOr4BK+F1zzuPvpnYiuevBYphwpUv9w6UflMxfExVeydng9s
 8KpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784629474; x=1785234274;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LNIPg2dSS4jXhhK8MqyiNnYyZwPU/+lIyDmHUjXxBN0=;
 b=GK8hRj/xAQHF7YHauTvf45rlyLhpkDfmMLuJuvLKI0LPDVgQkXGgRTEyC0bmQ7S6YU
 76KrGST7ZwEIORVx4FHSzPKj0cq2j9V82OLRf8+YAuV+LTIskwruVyUwnpxzPqiIiHQX
 eXoOkLdTqlrLtbb+zHy+5jGCAkEzcf1Wmxs1SxOtct9nkxcwew7AtkJoD/2GhtB34JX7
 3396oKV7XFQHNW6CvpB4qHQv5IGoGgbwQhdXCPgA+6ePOE2jdyN2uNRpYsaWJHBefjK9
 naPFLA7R8/YoQVvnBSmS0RGmOdFXDen7nFgbXaaBiMRV6tactKUqMdnofHud7GBjuC4T
 MZOw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpKyMl4Rot8xrgqFCPznSb6CnJq3npgvKiobbockRr7Z2aQSX1cT9/z9d4dOkZH/gAsWuI=@dpdk.org
X-Gm-Message-State: AOJu0YxAYETAyu+q1FGbkA8wk7vmLYccgeIqSnP2LNBBgLK58jf7wUBe
 8GaVHsfdOmU18JILYLITw3LvSbJS7sbAezCCfG7jHsVvJSA2YSmUOeiGKhO7za+PN2FpVb9e+Rw
 fNQBfaLMDJQ77yf0vSVG070pYIudsaCk=
X-Gm-Gg: AfdE7ckcvzONskiVHFhliYUfvLpFtTeSRL9m2YovK7yTucA4UVfOhkoEYcBJxZWnCu5
 rDV89ltPvl1L8NLcYKhYe1QWgde8TCLl92T1BbLKdiG3icMWVaonYcGt5DTfaU+AVvPWFE8sK+z
 OfYIOVlGPzLITgcQrTvpxYnpbthhT/T9Kz0pXCovcN00PLIYcnaxG+tRn+MamaUY0WRPumX8tgZ
 NplBophoWaOUC6o0S4pvnE9RUh+lW1IOkpgKmrtk0auC69TL/pbENTaYxw+lvM=
X-Received: by 2002:a05:6808:4fe7:b0:4a1:296:adec with SMTP id
 5614622812f47-4a4d01de8a2mr12281729b6e.15.1784629473726; Tue, 21 Jul 2026
 03:24:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260603023207.31974-1-stephen@networkplumber.org>
 <CAJFAV8zhrp3ke9k_RnwG28x-M8MzhK7R+=BKvc_+piZ+a7VcfQ@mail.gmail.com>
In-Reply-To: <CAJFAV8zhrp3ke9k_RnwG28x-M8MzhK7R+=BKvc_+piZ+a7VcfQ@mail.gmail.com>
From: Nithin Dabilpuram <nithind1988@gmail.com>
Date: Tue, 21 Jul 2026 15:54:22 +0530
X-Gm-Features: AUfX_mzpflOjxyAPh40d4plh9392buVd0vVU6tAo_yHJVYOBRJVm8MTOyvs7l6w
Message-ID: <CAMuDWKQr7XaZdwpF_-DaNgOk6POCukygVyBqbk3Hrwggygw1OA@mail.gmail.com>
Subject: Re: [PATCH] doc: add deprecation notice about upcoming change to
 ethdev API
To: David Marchand <david.marchand@redhat.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
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

On Tue, Jul 21, 2026 at 3:52=E2=80=AFPM David Marchand
<david.marchand@redhat.com> wrote:
>
> On Wed, 3 Jun 2026 at 04:32, Stephen Hemminger
> <stephen@networkplumber.org> wrote:
> >
> > Inform users that rte_eth_dev_get_name_by_port() will add a size
> > parameter in next release.
> >
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
>
> Acked-by: David Marchand <david.marchand@redhat.com>
>
> --
> David Marchand
>
Acked-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
