Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32ADCC43458
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Jun 2026 09:30:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7101140653;
	Mon, 29 Jun 2026 11:30:50 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 4F33D40299
 for <dev@dpdk.org>; Mon, 29 Jun 2026 11:30:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782725448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b0dT/p2jtXmVjx56K8CbRYt2Jr6psI8bAiRYvlCRwts=;
 b=H2ro+2/h5q3dh7A+C1Oageqaj0OIDAZPsTsQLaeXJzfcEizDvyzFlI7pHgxJw+ROuNHsk+
 q4XTdxlTHwjL3e2er4GJ/6QvSkLT/BdicUGGwLDcyyOIgecOQxObFSK41ysKqj0fX5tgHf
 TXQYT6SR2J3LfxpQfKuUlg3O9wchNpw=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-VjLOJDb-NPCaTRUBZX3-Bg-1; Mon, 29 Jun 2026 05:30:47 -0400
X-MC-Unique: VjLOJDb-NPCaTRUBZX3-Bg-1
X-Mimecast-MFC-AGG-ID: VjLOJDb-NPCaTRUBZX3-Bg_1782725446
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5aeba222aa2so334888e87.1
 for <dev@dpdk.org>; Mon, 29 Jun 2026 02:30:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782725445; x=1783330245;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b0dT/p2jtXmVjx56K8CbRYt2Jr6psI8bAiRYvlCRwts=;
 b=e/drnYvn5lgymbSZ3GJl+lVHWQ0ywUDJTE6ASLL4Y371Gb5tpUGIQvfFRasfOLotUW
 2lpwsXn3k873Ca8hZ6fnZW16euBbhjtuoip9KFtd9541fIFuTaJjaQWQb17DfhdoVAZq
 EJlBQDr8KrzpVG2FWAoWPNNzJe+K9v/ha8mD/iUub+8WbVyE7N2CPD4tmjveVieve8T+
 M/NpVdESV6RPS+FKigMfNZfEhibBXexzpWNczfa+sp+VefvsO6yrPTAuFkc4rCcwQ1W4
 Tv0OlqJTKcqoLSSbhJxH+6gafbqCCgV4HHSjLh9NifkReONf8RJrpIbJsny5MErbbdJd
 89/w==
X-Gm-Message-State: AOJu0Yw1fGODWFWfQcj7v2/BqA9bLE0s3NN1vkNmQPus9I659naBJ4NF
 H/JB7yqF5dHCVTl3uYnDxcqH54N93RES3rNFRg2vaDfgz1bwjWxBmTwWg2FrabNmeDev7jJW0Mg
 FaU5NB0Na0uA4RvHbWc4UHh0+77+6pUq9pCFRMyjaSjNhYy54gHa9Gmj+HE+RfVTy6YvOgzmj42
 24WqRZW1nPHVJbR4ajVFuBaMY6v4Q=
X-Gm-Gg: AfdE7cmOQLu/hQbm2BOYLm3cOUjEbObZ2VSKBwiQa0tUQw+WBEaNdl6JqLY+WTlYj5i
 mhE6xyuLsgkE7kPNBWDVDNblLU6EzgZGgZA9sipCnnZaGHHvwjILfufxO4qqE+RRdir7hVo4DnD
 NmiJvSVVsym4MZMndjajpYKlneUroYzuJCoblbozbPlP8oxPY+Z1FaAAYUCLXv48aNBClJCgtZN
 FC6Cm12h3Z7nnGdApIU4474GjjfwyNBo5GbTLY1iriy6XKn70SIbOIQ+8k=
X-Received: by 2002:a05:6512:12ca:b0:5ae:bcc1:e05a with SMTP id
 2adb3069b0e04-5aebcc1e6d5mr68746e87.40.1782725445598; 
 Mon, 29 Jun 2026 02:30:45 -0700 (PDT)
X-Received: by 2002:a05:6512:12ca:b0:5ae:bcc1:e05a with SMTP id
 2adb3069b0e04-5aebcc1e6d5mr68735e87.40.1782725445117; Mon, 29 Jun 2026
 02:30:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260325014506.1866374-1-longli@microsoft.com>
 <20260624000531.1562655-1-longli@microsoft.com>
In-Reply-To: <20260624000531.1562655-1-longli@microsoft.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 29 Jun 2026 11:30:33 +0200
X-Gm-Features: AVVi8Cd_Th0QkEMZhiqvwldyUNYCbKcaISZDkTWanrl7VlmT4BPLigA1ggcfozY
Message-ID: <CAJFAV8wV0jNVSD5hBH7t5bQZLBuCfkwO8aeU-n2bKji1+dZzUg@mail.gmail.com>
Subject: Re: [PATCH v2] eal: return error on devargs truncation in hotplug MP
 messages
To: Long Li <longli@microsoft.com>
Cc: dev@dpdk.org, stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RiJqx-Wdt6fJsUcKnKYidnXQ3x7p0BMFCeO1HkeG5lk_1782725446
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

On Wed, 24 Jun 2026 at 02:11, Long Li <longli@microsoft.com> wrote:
>
> The EAL hotplug multi-process messaging uses a fixed-size buffer
> (EAL_DEV_MP_DEV_ARGS_MAX_LEN, 128 bytes) for device arguments.
> When devargs exceeds this limit, strlcpy silently truncates the
> string. This causes secondary processes to receive incomplete
> devargs during hotplug re-add, leading to failed port
> re-initialization.
>
> For example, a MANA PCI device with 6 mac= arguments:
>
>   mac=AA:BB:CC:DD:EE:01,mac=AA:BB:CC:DD:EE:02,
>   mac=AA:BB:CC:DD:EE:03,mac=AA:BB:CC:DD:EE:04,
>   mac=AA:BB:CC:DD:EE:05,mac=AA:BB:CC:DD:EE:06
>
> produces a 131-byte devargs string that gets silently truncated
> to 127 bytes, losing the last MAC address.
>
> Return -E2BIG from rte_dev_probe() when devargs would be truncated,
> instead of silently corrupting data. rte_dev_remove() does not need
> the same check because the length was already validated at probe time.
>
> Fixes: 244d5130719c ("eal: enable hotplug on multi-process")
> Cc: stable@dpdk.org
>
> Signed-off-by: Long Li <longli@microsoft.com>

Applied, thanks for the fix.


-- 
David Marchand

