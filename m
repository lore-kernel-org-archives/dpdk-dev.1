Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B467CD5BAC
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 May 2026 14:37:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 95B5B402E0;
	Thu, 21 May 2026 16:37:21 +0200 (CEST)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179]) by mails.dpdk.org (Postfix) with ESMTP id 8D8CF402A2
 for <dev@dpdk.org>; Thu, 21 May 2026 16:37:20 +0200 (CEST)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-303dbfbec77so6632341eec.0
 for <dev@dpdk.org>; Thu, 21 May 2026 07:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779374240;
 x=1779979040; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8oDNNwyibXzM3I4/AxW/k4oNsHPUmqXaPWV8CX7gdCc=;
 b=O43J92G5PodhpudrO5GA0o6kJnhY2WOi6Ry6ftGuEm/B5LpMxWQdvEvlCCA1hW+aML
 PefXVvfD91ffHSsDZcnENW5Xs+WVa9uh9aiM74CYsdXDt97cXhU+tNwJeDrLdpnOab2Z
 q1IieGg27c1l+cDRAR8xYI99vJnF2qhmVlrIRFihL5I+W9CGvG1w3hqXSiV1QNNMyyCk
 E123oDAX8XZFm6Rp66y2IlHH7slmcuS+gG9Nt/hfHIv/gVTihEWRUMvmpEcL7x5FSx5p
 eXJAyP+NnFAFShXaPeIDB2VMHI2prXp4cVQOQ1zN7S7Hci0/pFBoUMAhm5hqWTWkpkH6
 JKpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779374240; x=1779979040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8oDNNwyibXzM3I4/AxW/k4oNsHPUmqXaPWV8CX7gdCc=;
 b=T+ppI4UKF5txJmk/1l68y+LAeuvMGoFS/hbgOBQuUiQz8xjahVSsTG/t10c6LlRkxH
 6oDimCerS3LHgN+8WrBjybfZtof4Wy5AvGnhUJxmYpVR3QrmmF5HNaAZw1CHMw3xwgRk
 Mr9a8GndkuuG85TvE1pSOD0dCTIoHmp8JfOR/PBsZ3w0OSxuV619/eRWzDScU5pPMFh8
 agq9GlkAxbnlqax2a9hWnXdKM/n7MZF1vsWbyCt9B8Fq6W+igguLj3eg48Dhze6GH2En
 Qk4Gi8H7Ky/zhuQcytpj7k4+l9rldXhIJQpL6kVWdZFvVp4Vc6Gsol7Ceavp/zulniz7
 3Y7w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/VFh7Zwx4M2LS6T3z2m8FowNMB13+Z6busnDF2jAH8OK+NmOFQPixIAD1TvoC4k16+mTk=@dpdk.org
X-Gm-Message-State: AOJu0YzdPeqqPHYOHh+Xg59FwtKYIE0TSagpbzVPZJ8EZrJuW42g7c1+
 ySjd7yW5omMBo1fItgHLVCKTLwuzuSOuqrposmqEuuHv0H+7NvC6sZtAhl5bSUSJygU4TUjwiNc
 w9bCy
X-Gm-Gg: Acq92OGX6cldEafbtXz7eYQgrMLmQYT/wGhyiGncCB+rGi04cF5AD10gSujRCzX/N8v
 bw8Z/V1H7gb6yTwQNrzyGC05KKpVSU+Ck9uJAVcvABW/HjNBgOZSTGsLjrrROUV4n/IsuwQTkzK
 +NTWyAC6OGuIbhthTyJO4Hf5a5xrdVfOkAbmglSJnCkDdBi4pFu8z2RuOtQtW12tUArpo5iweN2
 8qXvjjW1TEO0Rtdf/bN8B1sPglh65gsX8e5cWcQip9wQXvdtYY15f8jRVuNWrwu0dvaPVLO3XyE
 DkjDQTnJmcyUAdWtSJ07/2tYv7Qd+t5ACzU2mByVMAY7dcqpJlkryf2ndukNUjIqrhDUXYtQzll
 O2hLiXh8tp2OoUpMk4B8EVMTSOBL/RCvjwFM/M/JPwLS6rqSpZ2AZkaMlKLrrtNZGimT5ANav0X
 FV+0YvvriybWA6Y9Wqv6aF6TewF9olGTVJZr/zoiuB1MNC3ySFdC7CrWtNbPetJ1B6jcgRIvPw7
 dY=
X-Received: by 2002:a05:693c:300d:b0:2df:71f0:e5b3 with SMTP id
 5a478bee46e88-3042f9716camr1885626eec.20.1779374239618; 
 Thu, 21 May 2026 07:37:19 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304435c2ea0sm601364eec.31.2026.05.21.07.37.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 07:37:19 -0700 (PDT)
Date: Thu, 21 May 2026 07:37:16 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: "fengchengwen" <fengchengwen@huawei.com>, "Bruce Richardson"
 <bruce.richardson@intel.com>, <thomas@monjalon.net>, <dev@dpdk.org>,
 <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [PATCH v2 2/2] ethdev: add telemetry endpoint for list names
Message-ID: <20260521073716.3a788175@phoenix.local>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F6588F@smartserver.smartshare.dk>
References: <20260520035641.50555-1-fengchengwen@huawei.com>
 <20260520093804.29102-1-fengchengwen@huawei.com>
 <20260520093804.29102-3-fengchengwen@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65887@smartserver.smartshare.dk>
 <ag3ME5EBdDSAhaW8@bricha3-mobl1.ger.corp.intel.com>
 <cd4f1bcd-3d66-4ffe-91d7-7ac1fdfe8c2e@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6588F@smartserver.smartshare.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Thu, 21 May 2026 14:40:47 +0200
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> > From: fengchengwen [mailto:fengchengwen@huawei.com]
> > Sent: Thursday, 21 May 2026 14.25
> >=20
> > Thanks for the feedback.
> >=20
> > I intend to keep the current dict format. This concise ID-name mapping
> > is quite
> > helpful and easy to read especially when there are massive ports, which
> > is exactly
> > the main purpose why I submitted this patch.
> >=20
> > In my opinion, adopting OData-style query would require architecture-
> > level
> > refactoring of telemetry framework, which is way too heavy for this
> > simple requirement. =20
>=20
> Agree.
> Refactoring the telemetry framework is different task, not related to thi=
s patch.
>=20
> > For complex query demands, we can implement them by extending the
> > upper-layer Python
> > telemetry script instead.
> >=20
> > So I suggest we keep this simple form here. =20
>=20
> If it is generally acceptable for DPDK telemetry that a request for a lis=
t does not return a list type, but returns an object type with "index": "va=
lue" fields instead, then
> Series-acked-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>

It is necessary since port list may have holes due to hotplug or the owners=
hip API.
It would be good to have a more complete query function that returns more a=
bout each ethdev.
I wouldn't worry about the size of the response. This is JSON and it is mea=
nt to be read by scripts not directly by humans.
