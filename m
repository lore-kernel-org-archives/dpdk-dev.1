Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A211606A31A
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 19:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iol.unh.edu header.i=@iol.unh.edu header.a=rsa-sha256 header.s=unh-iol header.b=BYCUJhyb
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 096E34025A;
	Mon, 26 Oct 2026 20:35:33 +0100 (CET)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com
 [209.85.219.49])
 by mails.dpdk.org (Postfix) with ESMTPS id 4027440041
 for <dev@dpdk.org>; Mon, 26 Oct 2026 20:35:31 +0100 (CET)
Received: by mail-qv1-f49.google.com with SMTP id
 6a1803df08f44-9179bfa9e9cso49754406d6.1
 for <dev@dpdk.org>; Mon, 26 Oct 2026 12:35:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793043330; cv=none;
 d=google.com; s=arc-20260327;
 b=hD3xqZGcPOyjxVjqd3m+3mhVZ751tQxcfdyo5+Dsbj9czXYzUnDGYXugPEPv3NsBSP
 0X68PyGyviqwf3tq/RMsvH+zBt7houUMIutLrg0BDvmSabYFySiX/qGGeetk6RiJt01N
 bJVTtZO0RxKgj6YgV+gpgaKWNGcZa1HEiZFaarfngS1O9D67N1hmfwoqp6Z9iHgb7BKA
 x9lDEvUrUH9Cstw/TwXNVPP+eUyKmCbTJG6ML/Rqbs+cF2+wyholZHX3li2gi9QRW5QN
 PEdStYJ021Z/PkcNy1aomhT19xPP+WB/tXIrYZronBF87zpSgKJP2THm4gVIzmHTa1TQ
 XRTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=lDhOQ/Jt/KfqzpwwnOmOVnWfwS2cpl9wQK2OQfyRIiY=;
 fh=UvadoFEtw7U+tXuwUBO7nq0MSb3tI/HFdDywuvCHO8w=;
 b=hYEBLtku8RjeuE2hj0R6RKW9DfbKMRUK9wRbOwvhYak1nIUSHHBxIgx0aIZwfGsTzC
 F6xCHUnoCHs/XNYZgX0syLwa9vmA3QimT0TAI6durIs8/u7o6MjdrTP24yW7UrilJJEc
 yalnV9JfwM1zhQyZ/Z7U17Yl2XsnJi4Hs6R1m724gf1kr/hXLWTM8YjER8CcIrgP5ZuL
 LkXqqMxpZfHnGZsEeIHBPZM6F/pczHq7PAKxDXPrAdVP+FgZDvqoyPdhYarCb2tVUHOn
 66+cSzyW6b2F91QM7r6FTVIQHQmcUsGYRwaPpbYqEauTsIif75oqt5v1dCo6EDYGPw9u
 Y+/Q==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1793043330; x=1793648130; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=lDhOQ/Jt/KfqzpwwnOmOVnWfwS2cpl9wQK2OQfyRIiY=;
 b=BYCUJhyb82B2rleV5PzG1FFkz1OYJxq8h9A0/4o//yqbDKYsjvb1cBf7i6+YGu9eq4
 qOwyMQ+cHs7TIolfaNFFRAGXdjSKUEih7oyVkPWli+BlVxqQ38MGjSFX5zMyhIBgRvfN
 cNeXuJKgKdByiZtVBcjeWGgm5SjpnSZzX8ePs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793043330; x=1793648130;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=lDhOQ/Jt/KfqzpwwnOmOVnWfwS2cpl9wQK2OQfyRIiY=;
 b=manQBUFor27yjUwaebMGPnNu3kZ3wuXOAlGVw5yKx/2s1UfusKXDgWATb9vqITakXb
 CDAE7a53nSOhGZpUeW+Bzs+gmb/dFr/GQPeYqkdO3YMGyAmENFVLX4xo4OofuDcaxXPA
 mMgCocH9rWxJFaqhy5acUaFLDfa7y1oGWY4nIHa2FhFGR5nyD0UN0TmDP3p0ab1EY74v
 t8t5Lldfjz7Rm6z7urA4Aex23PSEgUXnpdzib0AZvTUFlTLZiS4Qbj7gtKpH75BWTB9T
 GY6SpiLI6rdXLLkuFbkrcsNThViYsULjV7TKZEpNkEe6oe5PgRZO7ZRVT5nwGp7FGPt3
 n6/w==
X-Gm-Message-State: AFq9FYL/xTBqkuUibZ6tTDEJojgAAorA7Dahmyc8x4FSB93UJi4lYmGK
 HdLHQTjJ7YK6YjfjzOvl7Fp50BWcfr9Yl2R/D//fmikN1d06X+so5/RQa4HC9PC+SqYTay4HCQJ
 vjv0VlM31O9bqQ6PFZ7bhyvusB442maO3EkSpXjiEuA==
X-Gm-Gg: AYBFou3ZUAkSOoV1f4ODUMPCHTGNXKfHz3N6n9vBbwx1DkqyNKvJXL5iocLGdF7CtJj
 YeiBanLvfHgb5TFHXWcreOoxyNijoeUqJi67+FSIcXe3Fju4coyK6tJ+TmO9vFDqGhOMCImAQ7s
 jBBGDDXpdhwLAnNbMQXWlbcUDmvxFAn8q7KsdqxqAAEzVInjQwUyha/Um6ZcNjqa0WGsBOc5mxC
 rFyrPCJ0oq9/gwekgMz9vj+u85NUEu0FFLBRkioeMy9cksHyzyQ8yrGXuY7V7t2e4AJLuaTwPNr
 MmJnaoGBGXhSAQPrcprnql6XHKmLZEMJ+Uan5FhDe2ES7c4az9quYnd+4mbtsIovxgsSFMcSPru
 Eytbhc1uf0UfooO04ZWqiXlFeT8b1tieo9nDWF97pNWmZuzBfztQ=
X-Received: by 2002:a05:6214:d06:b0:91c:1fdc:467d with SMTP id
 6a1803df08f44-91c48e3364bmr129024976d6.29.1793043330047; Mon, 26 Oct 2026
 12:35:30 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260806164505.642928-1-abailey@iol.unh.edu>
 <20261019201342.903235-1-abailey@iol.unh.edu>
 <5c257d44-cff7-4ac8-acdc-90791884f8ec@arm.com>
In-Reply-To: <5c257d44-cff7-4ac8-acdc-90791884f8ec@arm.com>
From: Andrew Bailey <abailey@iol.unh.edu>
Date: Mon, 26 Oct 2026 15:35:17 -0400
X-Gm-Features: AclHuK-nltQ1CDYTZ_q1RC1ZOTkpaKfbURbtyjHKJ_CALDnmlZbS1vvguYmt_u8
Message-ID: <CABJ3N2U5mHSSgAisPH6mGUNfAwh++=qpi5+nno0RwE5AQLtRYQ@mail.gmail.com>
Subject: Re: [PATCH v2] dts: remove crypto test type
To: Luca Vizzarro <Luca.Vizzarro@arm.com>
Cc: dev@dpdk.org, patrickrobb1997@gmail.com, dladd@iol.unh.edu, 
 knimoji@iol.unh.edu, lylavoie@iol.unh.edu
Content-Type: multipart/alternative; boundary="000000000000c13633065ec36e99"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000c13633065ec36e99
Content-Type: text/plain; charset="UTF-8"

Hi Luca,

In regard to the AI suggestions:

Empty JSON file written when no ports present:
    I will add a log message notifying the user of the empty list in
the next commit.

Conditional topology setup may need verification:
This is a false flag, when the topology is NO_LINK and there are crypto
devices,
It is intended to bind them using the devbind script. Since there are no
ports in
NO_LINK mode, there is also no need to call _setup_ports() and will break
DTS if
it is called when no ports exist.

Crypto test gating logic change:
    This is also intentional behavior. Crypto devices are initialized
only when they
    are both provided, and performance tests are toggled to run. I
don't believe this
    to be an issue.

I will remove crypto from the example config file and resend, let me
know if I am missing anything.

Cheers,
Andrew

--000000000000c13633065ec36e99
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr">Hi Luca,<br><br>In regar=
d to the AI suggestions:<br><pre style=3D"white-space:pre-wrap;color:rgb(0,=
0,0)"><pre style=3D"white-space:pre-wrap">Empty JSON file written when no p=
orts present: <br>    I will add a log message notifying the user of the em=
pty list in the next commit. </pre>Conditional topology setup may need veri=
fication:<br>    This is a false flag, when the topology is NO_LINK and the=
re are crypto devices,<br>    It is intended to bind them using the devbind=
 script. Since there are no ports in<br>    NO_LINK mode, there is also no =
need to call _setup_ports() and will break DTS if <br>    it is called when=
 no ports exist.<br><pre style=3D"white-space:pre-wrap">Crypto test gating =
logic change:<br>    This is also intentional behavior. Crypto devices are =
initialized only when they<br>    are both provided, and performance tests =
are toggled to run. I don&#39;t believe this<br>    to be an issue.<br><br>=
I will remove crypto from the example config file and resend, let me know i=
f I am missing anything.<br><br>Cheers,<br>Andrew</pre></pre></div></div>
</div>

--000000000000c13633065ec36e99--
