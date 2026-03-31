Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D57109B468
	for <dpdk-dev@archiver.kernel.org>; Tue, 31 Mar 2026 13:23:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0760F402D3;
	Tue, 31 Mar 2026 15:23:19 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 67354402C3
 for <dev@dpdk.org>; Tue, 31 Mar 2026 15:23:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774963396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IZboiRsCyjErJfBTNJmJ46W8hSfy5dUHSqAajlCJhOc=;
 b=bPpsjIEqZClszhOlR2MdqueENh+DK1jRc/FfmIws24+WszBqdYjrpK2XKoWs9N3aERTtP0
 1/kkxQLGMCYdfelPpuXhI0lQiAf9ZwqS6YENhTeYQdwiaJ0jkMBh/ADj9KcKQQCu2c+65G
 lMjHmg5HsR/9yVJq1RrnX4dOAMX82QU=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-r5YyVJlKMS63PlkTb1D7Ag-1; Tue, 31 Mar 2026 09:23:15 -0400
X-MC-Unique: r5YyVJlKMS63PlkTb1D7Ag-1
X-Mimecast-MFC-AGG-ID: r5YyVJlKMS63PlkTb1D7Ag_1774963394
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-38c5486a204so27040361fa.1
 for <dev@dpdk.org>; Tue, 31 Mar 2026 06:23:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774963394; x=1775568194;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IZboiRsCyjErJfBTNJmJ46W8hSfy5dUHSqAajlCJhOc=;
 b=oF67gxHFlHWldghfrNpiauzvoe+tMkEUCsdXAsjx8TVNJQNaAbK2d5naxvijCbtv64
 /fuF6RS4TWYtrrgOGgmjTqT0gxItWbxqzA6P2Gok4iSiAVMN0WmxoCPWaWFKheDQd6dz
 ve+mG1o6Y5J7gt8C+iazx3brH8p5abRQT7Dv8z9lOAGwr24cJECT7p4cUE3bDC9yYTW6
 BpT3c5FTG/0hbttDTx4UzO3gnINtJDTUCYHws5winxMwrFAbt3jn7oXcBKEODVjjoe8z
 T9cOvlkQXIkyvkfWbq1AK5PBHS/nbuxucmwy3xRnP5SNX6m3yIbuEMRNtw2fbxapa6bU
 Xc+A==
X-Gm-Message-State: AOJu0Yz8ia/gAvQNaF1jxnWMnC5KZtvaUhbJRVOhqrs04lXjyR2f/d49
 GpFimgUUpNzIs7mXgTWE7bCgxKYSEE5kQpw66M9tSgr/V7zktUhhidBM9XIgzNig6k0xddpFvM5
 I/2xMZiRAMKvTJxD61BWW+qJZkIKCVYmZ0C8eFlVOdmNg+i1NUV42gJoIq+RRDAETKA7CuRdKFc
 qzwb7MxGH4KjTuV1jPUchja01mqIU=
X-Gm-Gg: ATEYQzyqGSLi635SFL9rC+nALkfYqUpBpLUp6b8pKjtezGKozfD2mDv1lHaodJB5J+8
 W0Tz2/wLZM0bSbJf952vca1s9xU53kJsnSTHcsOHC3nqmmvJaWXpnMQQuz9hrxQuh/OVUkoIcGR
 eerZsTc6mNwDs0lxFK/lKwuZCnQJuTlqSy0xtwdcWLaIDs4apIw+7R5ySJlBwS/d29dDsj8y7bC
 4ElIzL0VS6NEglSJ52Ikk64kSY9b7KeD6rT2zZmEyHkT+6p/VopULjWEaXAK2aNCkhpzA==
X-Received: by 2002:a2e:a99d:0:b0:38a:5339:e667 with SMTP id
 38308e7fff4ca-38c731ea118mr68349061fa.1.1774963393846; 
 Tue, 31 Mar 2026 06:23:13 -0700 (PDT)
X-Received: by 2002:a2e:a99d:0:b0:38a:5339:e667 with SMTP id
 38308e7fff4ca-38c731ea118mr68348841fa.1.1774963393283; Tue, 31 Mar 2026
 06:23:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260331130120.2471971-1-ciara.loftus@intel.com>
 <20260331130120.2471971-5-ciara.loftus@intel.com>
In-Reply-To: <20260331130120.2471971-5-ciara.loftus@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 31 Mar 2026 15:23:01 +0200
X-Gm-Features: AQROBzDoKSTRiMQ69MPexhDV-RIjRmWtd50tVroet2756Zfaielh5tNFRjEZNZE
Message-ID: <CAJFAV8wKTewsok_2BHhF-+AxZ1r0XN6FZboOS8jEsa1s0ABekg@mail.gmail.com>
Subject: Re: [PATCH 4/4] net/iavf: fix reset handling error log
To: Ciara Loftus <ciara.loftus@intel.com>
Cc: dev@dpdk.org, stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CFfHLv7xWLgbCgU0RYAnzUVADJblHCfLcSDUpIYOKgs_1774963394
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

On Tue, 31 Mar 2026 at 15:03, Ciara Loftus <ciara.loftus@intel.com> wrote:
>
> Commit f665790a5dba ("drivers: remove redundant newline from logs")
> intended to remove the newline from the log, however an unwanted
> character was left over. Remove it.
>
> Fixes: f665790a5dba ("drivers: remove redundant newline from logs")
> Cc: stable@dpdk.org
>
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>

Oops.

Reviewed-by: David Marchand <david.marchand@redhat.com>


-- 
David Marchand

