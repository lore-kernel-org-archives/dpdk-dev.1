Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21312CA6017
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 18:32:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3558140A4B;
	Sat, 10 Oct 2026 20:32:27 +0200 (CEST)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mails.dpdk.org (Postfix) with ESMTP id DDF2440658
 for <dev@dpdk.org>; Sat, 10 Oct 2026 20:32:25 +0200 (CEST)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2e8246b13cbso5796485ad.2
 for <dev@dpdk.org>; Sat, 10 Oct 2026 11:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791657145;
 x=1792261945; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5MEHhaqXke/EOTSsMJ5nV+l9RqH+e7KZoKdmhB7C1IQ=;
 b=dr0ZppHuYPV9B8tHgTT1iRAGh35WTfmpW3kkoVQEXuY2iouNZZgi9WBYkhrWlix3ZF
 RXT656wIM7EAsU6RRpAKlZhsDCht9XFrcDVnPNWiDXcRDnvuD/BtGzbfofjP1FKM91h2
 nPJt5xzP3mZGCjt38JfZsY/sqvWsoKSl1saCAigufy7eN/QXoD88qA1GSthHHhcySOcC
 jf7pGazdGCjdjjZIMBL+TaESKYeZRCWlVR8tRDHd+Bz1ESw8mm3tZC2kbcLocvA6VwQt
 TMRWalHUS8GnEAV7mY8gUskxnZ5aChbVV070SuC3KMsXXZb7li0RdCkLt3jVWgv8lINp
 JkJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791657145; x=1792261945;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5MEHhaqXke/EOTSsMJ5nV+l9RqH+e7KZoKdmhB7C1IQ=;
 b=ToED9gEvaee3yRY0w+v1yNDtbpXuWZ+NpceIQ1Zv25+Um4JO/n1X1k2bYaCfpeG/8f
 ikNqQYUqfOIw11XK7C/DuxTPLJhvHCJf5BIdfyNRHOY50mMc1LZdNG0c/x+K5sO1MLcP
 FFesHMMHi99D9nKkh3EC+tyBD/cqve9cUshnJEYlDa6LDZzQlVuJZ70msCKMRtPcKSOx
 p/f2wbaYW/S2O8ZDVGugPo9w/B0hl0usqhEEZOuc3jKPid/eO6gE8s9QrGKbYuuW5uuu
 Sq0DjloMr8Bp9xR0OMUF+b0W+eoqwTZLlBUkbxyKUIz7pGx3oFhuWoz2VVM6Wue3EFJk
 FgFA==
X-Gm-Message-State: AFq9FYJ2z6VceyE7rE3WW3iZGa0rz6q7QMJ9rQsPfBeayL8yNpsAV1Nw
 f6vaoJfPPjtwDSqu5Wy1yvO1SeqIeaG9Qc9QL/aBGCw1xQvR1vIL8dlXwkp7RtQi7Ro=
X-Gm-Gg: AYBFou30Vip/hBjR7GhCjEcP6ODFNF1kHFCWjw7HdlWAK8qytRM4XdNB0ePB+whnzO4
 MLlJiOg6jr+wqcx1ZH2sta8zoKaalk6Hcym+O3XfoNUnVF9or0AMLVdd/g0q+9XSd6Iej0wehIR
 Z5xIvTIASl+llGZdA5TkvARoX3kks3oY21AFApls0qO5BiweTPvTsQL/qOmdHjlotcfOODl+UIr
 +u6lIL/kQL02HQJlQIc3qephfjpSo1PlYGx0DRf1USy2Ds0+CnPHdEG5YzTT90jEwuDivT40pzW
 6rnWHEPX0EarUSGorp4msovkqsKAdPxtoi+Wp1lng9N58I0xxsOUoNs5qzEjgwL2xBYLe/CGOE3
 nfWRA9eU+BE5Ro2hL7yyAK/9KnmWtuGQ1+KlTKeQA9pRC+3lh/WrkLv0o+CWOEdhFDgZoIh6aTk
 lFspH6lAyaMHx8rs+Yj0h9Hxbyai7V57oAfjgzMtlPzrs6M26RdM6mXxBayK8XnlX+Ev1w+RPG1
 5D5YW/VZxETD2oWxzpCJhjOl8FK+yuN9J/Ru44r
X-Received: by 2002:a17:902:f54f:b0:2e4:b37a:d573 with SMTP id
 d9443c01a7336-2e842bdbacbmr45083845ad.47.1791657145046; 
 Sat, 10 Oct 2026 11:32:25 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8419ff572sm24651035ad.2.2026.10.10.11.32.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2026 11:32:24 -0700 (PDT)
Date: Sat, 10 Oct 2026 11:23:47 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Roman Khromenok <roma55592@yandex.ru>
Cc: dev@dpdk.org
Subject: Re: [PATCH 2/2] test: check newer SFF compliance codes
Message-ID: <20261010112347.74d942a8@phoenix.local>
In-Reply-To: <b388a9625bafdfc95adbf1b9812c89c1fd910829.1791574390.git.roma55592@yandex.ru>
References: <835d139c746faff456f14755b7af7395b713bd70.1791574390.git.roma55592@yandex.ru>
 <b388a9625bafdfc95adbf1b9812c89c1fd910829.1791574390.git.roma55592@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Fri,  9 Oct 2026 21:34:27 +0200
Roman Khromenok <roma55592@yandex.ru> wrote:

> Check the SFF-8472 Fibre Channel 1600, 3200 MBytes/s and 64GFC
> codes, with 64GFC reported only when byte 10 refers to byte 62,
> and the SFF-8636 SAS 24.0G, 12.0G and Fibre Channel 3200 MBytes/s
> codes.
> 
> Add a helper to look for a value of a field reported more than
> once, such as "Transceiver type".
> 
> Signed-off-by: Roman Khromenok <roma55592@yandex.ru>
> ---

More AI feedback.

 
[PATCH 2/2] test: check newer SFF compliance codes
 
Info:
- Each test sets both new bits of a pair at once (byte 10 = 0x28,
  byte 133 = 0xc0), so a swapped mapping (1600 vs 3200, 24G vs
  12G) still passes. Set one bit and check the other is absent:
 
	data[133] = 0x80;	/* SAS 24.0G only */
	...
	CHECK_FIELD_VALUE("Transceiver type", "SAS 24.0G");
	CHECK_NO_FIELD_VALUE("Transceiver type", "SAS 12.0G");
 
  Same for byte 10: 0x20 alone for 1600, then 0x08 alone for 3200.
