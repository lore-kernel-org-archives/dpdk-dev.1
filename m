Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44132CAC5AA
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Sep 2025 06:38:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4AC354028F;
	Thu, 25 Sep 2025 08:38:58 +0200 (CEST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com
 [209.85.208.50]) by mails.dpdk.org (Postfix) with ESMTP id 060D740658
 for <dev@dpdk.org>; Wed, 24 Sep 2025 22:33:26 +0200 (CEST)
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-62fa8d732daso368593a12.3
 for <dev@dpdk.org>; Wed, 24 Sep 2025 13:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758746005; x=1759350805; darn=dpdk.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=v0y3JpXgvQZ0Jq1E6yYHTR34LMEAxBX9tkVFAfwIHUw=;
 b=aROfYEmGajqquA0p5eZOOwKT1MeemCuimvFR+ePwtDuuNCQ+JDhvFgPb3+08l6rkjX
 bmwNrhKRr7GlXNWD5MI/+RP/zWlgZuvxG3XNbBcCRKSlw36rqb/PcSAk8oTRpKD99Y76
 ckjKdK1uEXKu81XI4EdIgKNc1R4IUeZRpWXGgJQOvCdDTjxi0wk1J5MkD2Ni8D6lTEnx
 moJiXbGjpORr2ojHycfu3N7o/bPpQ3boNFGdskjtPst3Dvu5d3cyakDvI6sL1mNphsvv
 7lDMKnmR8s54T6poPatNwrJ8DlO3aO6gmN+l6RlUNZDsAC52Z/QVTiEI+trFjXo9Cfji
 ivDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758746005; x=1759350805;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=v0y3JpXgvQZ0Jq1E6yYHTR34LMEAxBX9tkVFAfwIHUw=;
 b=mHE7ORAUv2QCGj9OGCHVY64SvOmreJUix6CgVG88wir3myreK1lpkvK1UxFLHZ0nFz
 d6sIPjNX6jjiB5k86zrzGUGX8ao1znYgmPHpfzfBHrgTm7gQmcKNUylv/CBEo0/yNKzb
 m6HxdeFf53/zYdmQHmMZYb+S+6Y+G/VjXw2G5ihiFhVJQtqP5+EdbompEuyZbp988059
 CWF4k3b0UeqA7rY5JDYQtCeHPA5uGxoVI2VkJcbTmuU+ETs2LVuF/xHW+RdbMnRkk6BR
 RgB5/McyKabr5apNoN+Ns+Eoix6JUjEHq+NqCC+gclCTpK9KmZ0L5ivHQFiGjGFBpuLF
 AHSg==
X-Gm-Message-State: AOJu0YxNPiIXLMVPmTsRhEQ1H7/NtxdVu1IRxJNpGFOAVZrMXr0BTLvQ
 cTZoCcCIhxCUm/DQw0GcX7FtT+oUqqdn5C1q3DKbyUjNbAdXkq+fObkQlxCi4tgORrWWBKrcV8w
 fPMvs42IjdBCqyNinFaBPvT7Z3y33HQh9UabO
X-Gm-Gg: ASbGnct3FHOqSqD7J+0wWuU3w4TWkGu3SU4jB/HdiN43r3x2Fs5bJ08puGzrsIIvar7
 tPOcshk8i8wtkEfUvX2vnpZreGEPLYGIi7IpaAwwZCHvwIKFpbQ94uAcQhpcE+sg0TGvOVGA8SZ
 4xRMxvk0GFQu/jnd5Q+ByXq0otdLrgjfWoofcbXILYDxVxYpmpTYBgLdI/knvE8JnVLXAa3zssL
 +SjpuYw
X-Google-Smtp-Source: AGHT+IGOep0CGKAAqK9/jN97EHbCKWwxw3a8j3SKZoWAFmdRVrnjsmt85soqZro4E+3eTDNC/0kSafo+VS9wzvGAaws=
X-Received: by 2002:aa7:c694:0:b0:628:b619:49bd with SMTP id
 4fb4d7f45d1cf-6349fa92134mr539365a12.25.1758746005118; Wed, 24 Sep 2025
 13:33:25 -0700 (PDT)
MIME-Version: 1.0
From: Ly Min <lymin8462@gmail.com>
Date: Thu, 25 Sep 2025 03:33:10 +0700
X-Gm-Features: AS18NWBGT_xAct_pbY_Skp9tRgL-ID3EGbsNmH-NPBSQj4kY9U1CEUGvnJPGp0A
Message-ID: <CAO-XfvaeOcsWAkVdoFO-SVwETW8D7L8z=SOLAyRfpYtkKhDBZg@mail.gmail.com>
Subject: Re: [dpdk-dev] [PATCH] examples/multi_process: remove l2fwd fork
 example
To: dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000e2a3c6063f91f672"
X-Mailman-Approved-At: Thu, 25 Sep 2025 08:38:56 +0200
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

--000000000000e2a3c6063f91f672
Content-Type: text/plain; charset="UTF-8"



--000000000000e2a3c6063f91f672
Content-Type: text/html; charset="UTF-8"

<div dir="auto"></div>

--000000000000e2a3c6063f91f672--
