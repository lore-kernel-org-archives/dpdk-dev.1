Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05673C56205
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 17:21:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5463B4067D;
	Thu,  6 Aug 2026 19:21:06 +0200 (CEST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
 [209.85.208.42]) by mails.dpdk.org (Postfix) with ESMTP id 2C87F40262
 for <dev@dpdk.org>; Thu,  6 Aug 2026 19:21:05 +0200 (CEST)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-6a18840e2abso2598412a12.0
 for <dev@dpdk.org>; Thu, 06 Aug 2026 10:21:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786036865; cv=none;
 d=google.com; s=arc-20260327;
 b=aa11UNKun0mIos2fy674fZ7xrElJn/OSgcvAcy5XzZ5lZruYcHFf3Nmx3NpEJQLkIt
 k9siELPsrRJ+rSDWFHCsumcTd3FEzYx/oOteMhDThRfUy7AaxmaVL0498SDPTOWmh/oR
 weOJKoeisrNcjW20WaGeuTahbJ4V/8BI+uj65zRZVUzpnS7O4qPB2jQCn0M3JqiKl/js
 hq7CT3uqLQY9DVmx3P1whm0WYM9f0jjtxPmcciwS/QGHSX7KGnIunndxU7WSskUmu0Lr
 +Wh7RrLbnc1KkXerQWfHYTaxoZYHIGRt3J63KGvieCKpBYKugnpf1u1s74Ra5QfnqSxH
 Ta2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=WBbInHbNgz9w8anSHsyaLi7+KH8nsqXOLRpZNHBrOhY=;
 fh=X4Dg5IiIHR5eLmAJuvBq88HL+Xe4GQQoKuUc+TlspnI=;
 b=BcJeApHqtiSsuT1zeBXSf73EYDDGdXqokfwHTjyl2akbigk+RGleMxklmS0z8X/+fu
 cj/gF1OrrU7cKxXAsVC/HY5NSg53IO1rSnZRSNJj3G9pHhcAjf3znx/s9pWG2J7Ve8dK
 9ewnUfjMPyhf3b7KqkXON4OuLPqv5MV6dF7VduEpESm0V9DzgIU1bwgmeQGHYipJ7PUR
 Tmsj7oawppscQsQEye/+7FiyEH5lQICVzk6+2rirC88099A/yTpPUCIjlTnuZuy7ZOBB
 zjttyRI65W8EOVV9PB1iRKeola8M19dw/4iTn+tC1k5FD3dJqRvCYfp1nIeFybzTq3HJ
 CoCg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1786036865; x=1786641665; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=WBbInHbNgz9w8anSHsyaLi7+KH8nsqXOLRpZNHBrOhY=;
 b=JoSGkLfsuNNerjvPosF1IghpUtbVdHjOLhdjwe+2+bWgmQMRrlOSXMw3IIUoyPObOm
 GkQxyTnY6Z3hSTcE5GSsqdJPimPDRoMUexzBrN2+Gl6l9duisdAgpvfFqud6vP9goTmf
 Uon+s/ldCSQdWtx5/oxCTCZjVcGlZVjP/mzzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786036865; x=1786641665;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=WBbInHbNgz9w8anSHsyaLi7+KH8nsqXOLRpZNHBrOhY=;
 b=ghtDtchqG/O4LjN1Msmn4toRdT4Wy311GhSM5R4+LXxqeDhQjKk8UmMJCx6681I+PD
 /OYzt428ydkp9kJA8JVMRyD6YkcUcbyJOiQ1087zOBhIL133gLM1oyXAseRhDUfG0L0X
 /i3cklZgh5Gcx1UHGs+KOAtyJ7Yo/PfXrbgqgHV+YxxAJBnSi4yYjI26NjJ+uN2IgiL6
 VaeaGwsblSqv0nC0UD7MgHhFSYLjZIwBA/s6jwDkfcejammmwvd697V3lELyagwAgt8N
 Em7g4vDDogWpRt015+sSlYTUU65E37RqYoPHeihf3zOU6xrc3t596VXVlx++JOU2mN/L
 xz/Q==
X-Gm-Message-State: AOJu0YwPF/+/0iOQhH6WMJc7h4sdAU25yLGoqC7xQ8OCVw8NhVk82CmH
 IUybS3h6C/1kBbQhJePunLJuncInO1Pegpnh6MFpOW/iwOdYf3hAWpbUL8JEyVZrx3JMIMNd5NV
 NCeA+tpuJ+KEDFZDkH7GnxQLGxDVbBJTZHsr9gFdZwzqtkMNgaaEiRUs=
X-Gm-Gg: AR+sD10PzXr3liiv183JT+13qTMQ6ATv9UjPhN6R/OX0AUdB1EhG9ISoTMxOCuqu9rN
 MpVLXr046Bo3TiptjDXx4Hs2HKKn5FoiDoPEomNtzc6hKfuiXCywIGwwuuSNCFhvwkla8BQcmqa
 kDdfHtDgTOCqAH+T1RPpgofQNXP14ARR4ov1dr2p6WbL9Iq5SXF0AjP4+1W8QK98ShMqVrh8sAM
 XTn1SXGDO3CH8q8O9dabOOrNAt9wjA9dyRBhjnAheDV8BbolwGCxSda7/NRtlKLhPLI3ocnekoQ
 hvtBUc3YhBSWPrgCY8CCOYhdd52N350Somaov9WCAMN1wZEQ4O46tzMbpGHsUqCLbo8fftI=
X-Received: by 2002:a05:6402:2554:b0:699:728e:48c0 with SMTP id
 4fb4d7f45d1cf-6a14eff75eemr7806753a12.0.1786036864766; Thu, 06 Aug 2026
 10:21:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260806135346.568766-1-abailey@iol.unh.edu>
 <20260806171636.656181-1-abailey@iol.unh.edu>
 <20260806171636.656181-6-abailey@iol.unh.edu>
In-Reply-To: <20260806171636.656181-6-abailey@iol.unh.edu>
From: Andrew Bailey <abailey@iol.unh.edu>
Date: Thu, 6 Aug 2026 13:20:53 -0400
X-Gm-Features: AUfX_mz0aPLveIFgY6RtE2hjZpgLdahtW-lw57lv2-KUzySqM5fGeK3t9o0GzSo
Message-ID: <CABJ3N2X4GacmA7MX7zwLUPNpdnT9fnRwcayiXQhMU2nespZAVQ@mail.gmail.com>
Subject: Re: [PATCH v6 5/7] net/mlx5: remove versioned symbols aliases
To: dev@dpdk.org, luca.vizzarro@arm.com, patrickrobb1997@gmail.com
Cc: knimoji@iol.unh.edu, lylavoie@iol.unh.edu, dladd@iol.unh.edu, 
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 David Marchand <david.marchand@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000e168bc0658641ce2"
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

--000000000000e168bc0658641ce2
Content-Type: text/plain; charset="UTF-8"

Hi all,

I sent the wrong patchfiles out, please ignore.

Thanks,
Andrew Bailey

--000000000000e168bc0658641ce2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi all,<br><br>I sent the wrong patchfiles=C2=A0out, pleas=
e ignore.<br><br>Thanks,<br>Andrew Bailey</div>

--000000000000e168bc0658641ce2--
