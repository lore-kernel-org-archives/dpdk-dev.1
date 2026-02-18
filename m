Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF97E9A03B
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Feb 2026 09:42:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A493640299;
	Wed, 18 Feb 2026 10:42:02 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 6F94D4014F
 for <dev@dpdk.org>; Wed, 18 Feb 2026 10:42:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771407720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aswr/8T3W7PTS/mDm2Yz8LlW7zSrb35F8iuZVEGn8eU=;
 b=CpQHLBskPtSZKWBPLjhg7egXakNxte0jNWlmJ9T/VXTIm2idrPYELafrWeVe2RBD5Ic0VX
 cxpfZ1CHmIFL0oMuj0AxVnrPsKK87RfhO8Sr/qd6jbf8JtTlVtETE50O1MbZFpr7oihC71
 Ztr79eZfR6zI6yWXcnvZxebe4I+o69w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-yXTF7SDaMoOU_KLQQo1K5A-1; Wed, 18 Feb 2026 04:41:59 -0500
X-MC-Unique: yXTF7SDaMoOU_KLQQo1K5A-1
X-Mimecast-MFC-AGG-ID: yXTF7SDaMoOU_KLQQo1K5A_1771407718
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4837cee2e9bso30909005e9.3
 for <dev@dpdk.org>; Wed, 18 Feb 2026 01:41:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771407718; x=1772012518;
 h=in-reply-to:references:user-agent:cc:subject:to:from:message-id
 :date:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aswr/8T3W7PTS/mDm2Yz8LlW7zSrb35F8iuZVEGn8eU=;
 b=xLLirrp23iAu96paDflAdtRmu7uZb1oYg4xl1lE6N9SPxRXxw9pnabaKktigueaDW0
 rv6RgStBUG0Yf7ggcwXnFcUhzuVAsW5sX2w4nDHmwqtPeHWG0gVHyTrla7u3Rvw569Je
 h8gdI8KfZQIZgP9UHayej7y/SyFHKKXDurrsXvj5ip+ZS5SgIfPwB6zwiyqewi0upDZN
 gotSnow0pFA4Y1sbIrERxm/YZa/Z5NWDKCfgZ8fAEzSqqJXrz1d6c9mTfe1n1pBAyP6a
 4x1g8wUi169HXCA2AnhfEOFNntLZdl6YZsBVglVEOV22wxsizBrcIM1dRQOuMNZN7plb
 Exsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKHfJtbPvXvQDbWFgBixt09udAu8NfGM8gJowkM3+7X55wwwXBBvkffMw7qi2QjCf4548=@dpdk.org
X-Gm-Message-State: AOJu0Yw0actXhqDiWM0uYMRIsL/NZGgxUE1fATDcUY+/5AZujDjj7hQi
 s7sjftHXzaB6PnmFH/OLSjvG1GXkU6QBkchyoE0zxiH+AEdyDSRjXYbW3l7SyXC9lLs66b88q6a
 uaqhuZMCrK4PoTNWDGIuoQDtVff2zGFZf5wq2e/p4x+AD
X-Gm-Gg: AZuq6aIGaAeWdtzlyGyrza4r8t/HjMpnthzYUiPqsHXrrdlLK3fo7gU4SQC/YZjimSV
 WgGo8pKNwza/meDXXKlPwA7BgzcNDQRt/KuBjitpXeUDn5N/hBdQqGOnJf0mR9jUX6HFD+zEop+
 O4W+1mD6xQsUwFvZcuFEZzy1kbJGECmnVRneiXr41NzEnwCWTDImBjg1O/CUyY2YBFs0Xs3pKDG
 1DJVZXFmGZcwami2s7GBT+ztqy6DrvG7oMCs9LIlbnrKqxsdWlxeXacG+7dVzROUp+rG7wb/7R9
 eLG2PyKunEgyhuTUbh7OpkhZWK+446urY0cJnvxDzcEF+oAuAK/aMRpCeaANvqnll23ZfyfVOhk
 8QmXOLi6hQtbxVHgw0qWSeBeYDXbS1ugdfbKBiAS0A5a41HYreDN/d2MJV2Pma3uW1yvCeleqU4
 niO//h
X-Received: by 2002:a05:6000:4310:b0:436:8f7e:a479 with SMTP id
 ffacd0b85a97d-4379db33f6amr27003160f8f.17.1771407718031; 
 Wed, 18 Feb 2026 01:41:58 -0800 (PST)
X-Received: by 2002:a05:6000:4310:b0:436:8f7e:a479 with SMTP id
 ffacd0b85a97d-4379db33f6amr27003125f8f.17.1771407717499; 
 Wed, 18 Feb 2026 01:41:57 -0800 (PST)
Received: from localhost (2a01cb00021ec000b06e6b63494bd4c5.ipv6.abo.wanadoo.fr.
 [2a01:cb00:21e:c000:b06e:6b63:494b:d4c5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796ac8075sm39357857f8f.29.2026.02.18.01.41.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Feb 2026 01:41:57 -0800 (PST)
Mime-Version: 1.0
Date: Wed, 18 Feb 2026 10:41:56 +0100
Message-Id: <DGHZMMMMIQHE.2D7VL676OEQST@redhat.com>
From: "Robin Jarry" <rjarry@redhat.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>, <dev@dpdk.org>
Subject: Re: [PATCH] usertools/pmdinfo: fix search for PMD info string
Cc: <thierry.herbelot@6wind.com>, <stable@dpdk.org>
User-Agent: aerc/0.21.0-98-g3a0874577a2a
References: <20260123162104.1854187-1-thierry.herbelot@6wind.com>
 <20260217124844.1458644-1-bruce.richardson@intel.com>
In-Reply-To: <20260217124844.1458644-1-bruce.richardson@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hyAnRmpJj-9ZlxifgpLMy2la6R5SI4JdcLQd5EqKTB0_1771407718
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
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

Bruce Richardson, Feb 17, 2026 at 13:48:
> The PMD_INFO_STRING constant string is not guaranteed to appear in the
> output binary immediately after an unprintable character. Because of
> this, in some cases the information for a driver could be missed by the
> PMD info script as it only checks for the prefix at the start of strings
> that it finds. Change the script to use "s.find()" rather than
> "s.startswith()" to fix this issue.
>
> Fixes: 0ce3cf4afd04 ("usertools/pmdinfo: rewrite simpler script")
> Cc: stable@dpdk.org
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Nice find. Thanks Bruce.

Acked-by: Robin Jarry <rjarry@redhat.com>

