Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC91CA5FA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 12:51:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DD691402F2;
	Tue, 29 Sep 2026 14:51:19 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id C11904013F
 for <dev@dpdk.org>; Tue, 29 Sep 2026 14:51:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790686277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yi94QP1OVhoIHVOy5zu/Dp4ymFoRqlnL1Z76AUwYR5M=;
 b=A/KnAQqqYI0EMqk/XZc0fDN/ndE2auWTF0ocm1CCiElvZ3q3CN4ISGhKH6Xtm0rY5IbS1M
 tz7jE3fVtqsWo7o5QsQWO6vOkS19UyiWMxsg4wSUXaVFimVKrKgV5h3mfYiFsD7aG8bO80
 zznsG8Zt6ZpuJcFO/LsCwU/GeXBpQeo=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-viXmMdAPNUa5sKm-r_Z1TQ-1; Tue, 29 Sep 2026 08:51:15 -0400
X-MC-Unique: viXmMdAPNUa5sKm-r_Z1TQ-1
X-Mimecast-MFC-AGG-ID: viXmMdAPNUa5sKm-r_Z1TQ_1790686274
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5b2d7c7ec76so2117880e87.1
 for <dev@dpdk.org>; Tue, 29 Sep 2026 05:51:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790686274; x=1791291074;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=yi94QP1OVhoIHVOy5zu/Dp4ymFoRqlnL1Z76AUwYR5M=;
 b=tuPQ3pZXlHdiV7ZWuqwCgaBls6cUJaFnC5NrpAUK0mN+QMSDn83aXwAF1e8ZfgHd6o
 afAFVOVC9uBJi0GS0fKVTriUTUMCqghg/dVtQAy1dvnCbrt9NKYG97xxb4cbMa701GCs
 V1dQWdQeM6qlxT1bE6d0ah65GZWZgtFmK43DHxMXX9nNnMOX6yZBa7cj6ZSr5TolQV//
 gqVaoQqlH8O8rdUcO4grdGx7gr70NGY/+V5cs3Qgm89YjZjJ1geDW0185I7cuUJdzpxn
 ZDQAB5JGgUcjldmrLrCIHHjuudcDWejPm5M0F43qp3S+WBe5wV0/KH5WwYZ5C09hInri
 n9DA==
X-Gm-Message-State: AFq9FYJ+dIvuZ0/mE5hxnMjXUn1w3SfAZ/zYvoyikfWiHcx8IoJgZyJH
 DlCRZgNy14dmPqqQSfWA1m6/2vdqMeX7TLtQFasUBDQ1EXvoxYIgB9d124ztqZLzqwR8qNt0SD6
 H1/iTBiupmymns4dhl9sYg9yyWdS9CUfXs/nuiRcNM0iXnsWciOPYBBZfJekglUT5p7MmlmnLka
 VlQ1KvQW0EVg8ywERNu7I=
X-Gm-Gg: AYBFou0/PPfeqdsTwtw0ZnNlS2ayL8j7ezVZGN71gLbf53CegMeWtgEEjHp6GGww+Wt
 I/a/v5vYZpbVXkBXqtwZVR40tab1/EyaQ/jb7Sih0oQR8dsi8NJH008iMdDXA6SEj0rR/vHbj6t
 8GXxSoM1K7bijGW28jeKlhYesQN/FblzQi15F2UNBqbA4uTMVXE4ovI1jRCVe6IrYJD0atrt2q5
 XHH8C9Y1UYSMtmqwcnwQU7yQuyzU/QgLnIF0N6bOKel8oGk
X-Received: by 2002:a05:6512:3e14:b0:5b8:f4ad:6e4b with SMTP id
 2adb3069b0e04-5b8f4ad6edfmr2918423e87.18.1790686274169; 
 Tue, 29 Sep 2026 05:51:14 -0700 (PDT)
X-Received: by 2002:a05:6512:3e14:b0:5b8:f4ad:6e4b with SMTP id
 2adb3069b0e04-5b8f4ad6edfmr2918410e87.18.1790686273649; Tue, 29 Sep 2026
 05:51:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260929124437.87637-1-konstantin.v.ananyev@yandex.ru>
In-Reply-To: <20260929124437.87637-1-konstantin.v.ananyev@yandex.ru>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 29 Sep 2026 14:51:02 +0200
X-Gm-Features: AclHuK-JAWqHWbM-mui3mmkLxjFT3eVkzwWaCTDo-euciWqNZGCmeFeJ7CclTi0
Message-ID: <CAJFAV8z5pdJ-dFLp8OsFTHD+S+6ty75QwuQUpfhNDT+-_0bx+A@mail.gmail.com>
Subject: Re: [PATCH] mailmap: remove obsolete email addresses
To: konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QqLt4cPEKtsZL1Lvn0-rOOvBB0IfvRwtkTKeW74E-Ng_1790686274
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

On Tue, 29 Sept 2026 at 14:45, <konstantin.v.ananyev@yandex.ru> wrote:
>
> From: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
>
> Remove email addresses that are either already obsolete,
> or will become obsolete in the nearest future.
>
> Signed-off-by: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>

You should leave them here.
The mailmap entry is used by get-maintainers.sh to find your up to
date contact address.

If you were involved in some (buggy) commit with your mail at @intel
or @huawei, you don't want to expect the blame right ? ;-)


-- 
David Marchand

