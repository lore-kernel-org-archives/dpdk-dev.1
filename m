Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C222C56205
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 17:20:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DD4524027E;
	Thu,  6 Aug 2026 19:20:34 +0200 (CEST)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51]) by mails.dpdk.org (Postfix) with ESMTP id 4E8E640695
 for <dev@dpdk.org>; Thu,  6 Aug 2026 19:20:34 +0200 (CEST)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-c1f758014b8so235388866b.3
 for <dev@dpdk.org>; Thu, 06 Aug 2026 10:20:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786036834; cv=none;
 d=google.com; s=arc-20260327;
 b=W9QoPR7pYVfooppEZbGYb4Jcy0opej04mDM8W77DzKhTo/1sUVYRVT/CnrPVQoAQUi
 7I2nRzli+9DkREzAgg8JTZYUGH14BlYSZbSUCg0mw4L0sgPH2c6IjnLKzFsywu1B4r69
 GPB4Og3U1rHY4Xrz/OPK3mg1gzQgc39pF+8Y1EOWi+66TzLewbZA/giXrrjxWTeVK7NA
 T+FXZsAnvFMAp1V1+5crcugEwawL0JGbheKsVKodkeSpiG7cRnDHr7XTS0jLZjBfQAF9
 RhCjMh6xUbaa3ibsmzn2PzV7jXwqCDnU42HrRKMAOK/TLdVT0Z4ulfcjXGYXLkBaax5s
 xv7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=xg2mwXvP+gpW21un+MchUTAi1+Vm/63X7n4b7whPh/Y=;
 fh=X4Dg5IiIHR5eLmAJuvBq88HL+Xe4GQQoKuUc+TlspnI=;
 b=XNf+46b3c1+tVKKjJaX+XG3viXmwe7SLEFhzjIhxPBgFDuaQUuS1INQcoSFPK62Erg
 s3hArb+xhEdaP3lS91BaH7EeEF9l1pOOL5ODItwnk/JpuArXLwtZpKY6kBWzjn6sFoOx
 Hf8RqNKf0pRMk3aq4z00e1KtlFhH/6ea24u2EgTaP3e31jH5HAoHhM8neY/JcDqKBPjM
 5aR6AJIv+n1Kq+Y9BKEmw+4QTI4C2Q6hWXwKS8AyYcHe4kQ2RdhLCj31tTLqzkaf5KO5
 DgnAC4apWI5nazibmndRLPbVZmlYntkA5SR+/7y75WQkCpmEF+fTwLi4t9aYFSAWv0yx
 Ia0A==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1786036834; x=1786641634; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xg2mwXvP+gpW21un+MchUTAi1+Vm/63X7n4b7whPh/Y=;
 b=dz8Fa2GUpVZmuB10KvjD965msZcX0ZBGg1FZdCYMj8F7jw9cffPYenLrumEWd05mP4
 M6uNrsCgd1vOUH9RLYPOZ+U/MFpZlQluSVnc1qllmz+1RDSSfUgtmD5KFb6OKuRmDyK9
 wlvwRnEee+dBXgizFEShf7yyBcIhao3TmnTJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786036834; x=1786641634;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=xg2mwXvP+gpW21un+MchUTAi1+Vm/63X7n4b7whPh/Y=;
 b=XR9gH/EqB+4aGHZ2ixMqJtcAWDG6s0lDlGWShXMlyG5H3rYdNwHWVYBZ11yXY0/8+f
 UsqwmfLdB6y6p+5sBRhND6u3VxUQNUlih4+aWvjspNt0r8NqADtifc6t/aDkyuZmv6O7
 8OEDp+MTcYrTI8dgGgnhwIdDVq/0pAaSAwbveymbteHCfcDBozSbaihiP9iZDIL6dKh6
 S+QNajnppmiX65qyHgGJ5fOhdYz2zkcyk6FPaFH9XxqReNRt3BFnbZg5rcrJKSgvDXAP
 S89ak4CRSkgeW45FucSuSFDl0Q1D+nuVj2MQfBgvjqvltl20rSdqN1ZmACJQVesJ/sJq
 UAiw==
X-Gm-Message-State: AOJu0YxNtYM69+ImY0s084ehx6k0NVFYQCoBFkGMKxougXYnnF9e9oFu
 uVWTneR5hWgMGEr57O0HwOA79jepthT2fDNBdvmq2EKslTHyktFN448Nwsg5lknYYW487lNIL+q
 v+mxk6CuMsFV2Rbia8hjLLzmdsn/b7UPo66lBYci4YF/NarOAytNXl+4=
X-Gm-Gg: AR+sD11NhXyWMAlpdVH/E2J/cYhs6ceGtUlQXxLWhXvf9BYAPemoUKbCYDKDdwNapow
 U9kZgdCB+E8vGiW4osmlVi+0JSUCuO46m2ZNfSiJdk3n8t0TWjCxIvbEoPc/dfr4oosXDmyvX3e
 DuDin0A+gujhqJgyGq/HqgvqPuw/5KpBhqkcx8SKDfZg2nKdF9r0oY/qXuWvhtYWiV7/qDezacg
 Xf6orqwYBQ5EzcEqtroVuXoOWtRtlLohW8ptgXZ4HN7aPPodHfz1OJfKfXm9Z0twhnYShqHz3+n
 7NbV0Ru/Yu5SoC3gdYpQePvyF+sGeeTYU3y195hBEEDPObrfTEBMpdIllH6V
X-Received: by 2002:a17:907:9284:b0:c20:38e5:ee43 with SMTP id
 a640c23a62f3a-c2039b79e2amr859165866b.11.1786036833904; Thu, 06 Aug 2026
 10:20:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260806135346.568766-1-abailey@iol.unh.edu>
 <20260806171636.656181-1-abailey@iol.unh.edu>
 <20260806171636.656181-5-abailey@iol.unh.edu>
In-Reply-To: <20260806171636.656181-5-abailey@iol.unh.edu>
From: Andrew Bailey <abailey@iol.unh.edu>
Date: Thu, 6 Aug 2026 13:20:22 -0400
X-Gm-Features: AUfX_mz5B1QzQ-GtPt6yqAi4e79cRifK8heU1ydgIyOO8Q9gRqKhfb21SQvloLQ
Message-ID: <CABJ3N2WFJ8tdaKxuES6f+n1_G4M0VU1NkWhA4MQH+yzXjPDqNw@mail.gmail.com>
Subject: Re: [PATCH v6 4/7] ethdev: remove flow metadata symbol aliases
To: dev@dpdk.org, luca.vizzarro@arm.com, patrickrobb1997@gmail.com
Cc: knimoji@iol.unh.edu, lylavoie@iol.unh.edu, dladd@iol.unh.edu, 
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 David Marchand <david.marchand@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000000a79a70658641bde"
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

--0000000000000a79a70658641bde
Content-Type: text/plain; charset="UTF-8"

Hi all,

I sent the wrong patchfiles out, please ignore.

Thanks,
Andrew Bailey

--0000000000000a79a70658641bde
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi all,<br><br>I sent the wrong patchfiles=C2=A0out, pleas=
e ignore.<br><br>Thanks,<br>Andrew Bailey</div>

--0000000000000a79a70658641bde--
