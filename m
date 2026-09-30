Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2134CA5FB1
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 10:06:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DB24240695;
	Wed, 30 Sep 2026 12:06:20 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id D499140278
 for <dev@dpdk.org>; Wed, 30 Sep 2026 12:06:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790762779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
 bh=Rmn+CzGEzwnS/LOjouYvj2Q71JzqE7z7nCRB+Y9L02Q=;
 b=T7Phyk5A28siUn3S1vPAKjSibZWQbf48HelutEt8ieUxOGN91/uAsL/iyNFAKCUth4Fn1c
 KhXi7wP7TjdOAlUwUMxfyRkYqtOkeXcMivRZgZfGVI+eiUdEZkkksedMROROZVZklf5oyf
 suqKLF35UBgSxy5n4MCj60pzmncUqo0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-Xev3siPHMQq-ejdM9Vy0ag-1; Wed, 30 Sep 2026 06:06:17 -0400
X-MC-Unique: Xev3siPHMQq-ejdM9Vy0ag-1
X-Mimecast-MFC-AGG-ID: Xev3siPHMQq-ejdM9Vy0ag_1790762777
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4a009f82bedso20931725e9.0
 for <dev@dpdk.org>; Wed, 30 Sep 2026 03:06:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790762776; x=1791367576;
 h=content-transfer-encoding:content-type:autocrypt:subject:from:to
 :content-language:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Rmn+CzGEzwnS/LOjouYvj2Q71JzqE7z7nCRB+Y9L02Q=;
 b=wFqCToVXkno/u7fDWtvQFkbiYfwA8Gjr+3DKzvIgTz2b5zE6Kon7LorxttVH6Dfr3/
 A/OPRe/9jojQ/Z/TdkQeGicE4fyQ6T8YMqHIj6PWrebNyEDNj9TXC+rpTHqMFjcW5ckd
 OoP7A5nn9O+utP/UhRJBaUUj26cJl4oP+gNlCOBfwHwqP0GGiDi8qk7GdtROdc4lEKHB
 j0hlQBNXZyovySzlI2MVD1YC7OZTY002Z64RNMOwZc/WQb8vp4esbtkvUJYupnMKKhC3
 qdJtALiIUlkUYZfB7pJzL3L4VOu+IqUx921Y4y1fTFkwxgJHfhHXzRBOO15MnSnWoiO7
 /3pw==
X-Gm-Message-State: AFuF++lgPODtjYWJG4Dud0CehadeQDvn24J69IW7iBZNfrOTScHKb6UE
 M5ondeCCi9lefYiNDGil69SJl9cCUgUVtjWhyWvf55APGve6mt5x1nCbjrEgiY17R4TM4t5dyFb
 LzRo7mwN6QX8fCdgsyGw0iGDPZmM1Op5qXkbZwhMFeykBkIf+xaNIRNJlrxcuSo+4/wgabIaFq0
 7wnx24dtK4f9iGbaq+/RuEBK6LWhrw
X-Gm-Gg: AYBFou3JYV1BxYdxT9w4pHq0jLKBgjML3RCVup8uXAKzNrDvrB125UHFs1aNja/mpQG
 kf5N1SlISfd5F8fOqA9Nb/CetitGQ8tBYE8HCRXi87+6FIjSgtIrEFwEPHIRb4MR1OSptYN/jWG
 3lsY34uCyanI3fQdU32jPjjG7G4WRZj3KveJ3JibsTqLM27xNDUTe2Bd+qQGEb2PE2kqqi8mEN4
 dwct6ZqUPF7yZ8Y57D8FnluPLCsTns2MF05T077kpiHcfZSspe0mgrQfKPTyqjOsPIbbRBjYFpA
 DeraPxMDh5giLcchUh+GKC5CNRMPfYrcTvnw8Y9/B+MD+feJn+Zdh+pwmRXlAMs/M9by9L7uOzu
 rY79sUD++w0kKKfRRa1WgiQTib9wYnR/t
X-Received: by 2002:a05:600c:46d0:b0:49f:fd2d:23d1 with SMTP id
 5b1f17b1804b1-4a01b126c87mr15355305e9.27.1790762776661; 
 Wed, 30 Sep 2026 03:06:16 -0700 (PDT)
X-Received: by 2002:a05:600c:46d0:b0:49f:fd2d:23d1 with SMTP id
 5b1f17b1804b1-4a01b126c87mr15354825e9.27.1790762776200; 
 Wed, 30 Sep 2026 03:06:16 -0700 (PDT)
Received: from [192.168.0.66] ([78.16.71.129])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0174d5191sm45197995e9.3.2026.09.30.03.06.14
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2026 03:06:14 -0700 (PDT)
Message-ID: <c3590dee-d7ed-4792-9991-59570406d8da@redhat.com>
Date: Wed, 30 Sep 2026 11:06:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "dev@dpdk.org" <dev@dpdk.org>
From: Kevin Traynor <ktraynor@redhat.com>
Subject: Minutes of Technical Board Meeting, 2026-September-16
Autocrypt: addr=ktraynor@redhat.com; keydata=
 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
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5xSNwp5_0jQPlGODuj3RHSkN8IpX2bw41sZMc-ZVoLs_1790762777
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Minutes of Technical Board Meeting, 2026-September-16
Members Attending: 10/10
     - Aaron Conole
     - Bruce Richardson
     - Hemant Agrawa
     - Jerin Jacob
     - Kevin Traynor (Chair)
     - Konstantin Ananyev
     - Maxime Coquelin
     - Morten Brørup
     - Stephen Hemminger
     - Thomas Monjalon

NOTE: The Technical Board meetings take place every second Wednesday at 
3 pm UTC
on 
https://zoom-lfx.platform.linuxfoundation.org/meeting/96459488340?password=d808f1f6-0a28-4165-929e-5a5bcae7efeb
Meetings are public, and DPDK community members are welcome to attend.
Agenda and minutes can be found at http://core.dpdk.org/techboard/minutes
The next meeting will happen on Septemeber 30 and will be chaired by 
Konstantin Ananyev.


# DPDK Event
- 2027 event was discussed at the governing board
- Investigating having an event in Brussels on the 2 days before fosdem

# DPDK CVE
- An update on Security process and CVEs was provided by various people

# Enquiry about LF and OFAC list
- Can request LF to give guidance if there are any clarifications required

