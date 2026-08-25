Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C36E1C61DBE
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Aug 2026 14:14:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E4B694013F;
	Tue, 25 Aug 2026 16:14:01 +0200 (CEST)
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com
 [209.85.210.50]) by mails.dpdk.org (Postfix) with ESMTP id 10993400D7
 for <dev@dpdk.org>; Tue, 25 Aug 2026 16:14:01 +0200 (CEST)
Received: by mail-ot1-f50.google.com with SMTP id
 46e09a7af769-7e6b5737bb2so6984749a34.1
 for <dev@dpdk.org>; Tue, 25 Aug 2026 07:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787667240;
 x=1788272040; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jk+cAYoM07duMXJ19WsadoCXwUQF1lELWykqwSqjqZM=;
 b=bSDyshoUJXZAXcMIHJHriEW48Xb/g/Dk7866nS/bXVWT/aKcx7CNA2iB/2Wnw3x2to
 dD8Jl8ZpPMXz6S9yXw17Ktnr7ko9D851Eu6Hlo1GVXPszLR/kLGtSJQ6oJVSkBDe6kc0
 he05ONmxQ/OmZAJ0W6za0fScMxa3d73ol9u+SLTF0h2POh7zDIRQYDu92YsVFH34hmee
 RDTFpVp57mrNr7mgs9oh/asgJLQudQEs7LEBCEVKhkzdUPuW8usHO1O/6K36Sbe+FCsK
 TAnlmIlbDgNrWliilHOLh2ilfE1eK4z14MSmHhLpAAndUnkhF+D6zHcb3x8dGBCJdHOO
 uKXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787667240; x=1788272040;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jk+cAYoM07duMXJ19WsadoCXwUQF1lELWykqwSqjqZM=;
 b=VlLKuLPQvLqx27AU4+08JP3YsqTm7QFOKeWQFy4XsVTxZq+GxshUN/E4fY/jy98Ohx
 xeCL+XvONJmgf+omvdeDGxVWDtnYqf4i7cZU5uTgJiLBzDmMP8mNSTE2uHmBcsC+OWOo
 McdEtOwHqmRy6RHEd7Tw9j6gLR3fP3qqoXR5/oZeDw9j6vl1bPEmMVG8Ef+9jD2/4nb6
 7MnVv6WclJyqdu8428bmGcesPuiY1yRzXrttniacVqZiSwv1hHbFj21lzWkCiKXABuqH
 j6ROkKaEruvtzTPikypB5Qc0aZtHeQlBws/13RfimFz5OHT93+32AYGutu7Gkkj0LY7W
 rlpQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpBh5Qt90+/zT0bbYVD6eAd3OJgu3/hTYqQgY4ihLwb519k5Xvb5W1lzHXEO9DC00xoRqI=@dpdk.org
X-Gm-Message-State: AFuF++lzu0QgjfKBME/NwTTlyqM6wtv6ifjqjUUzUU19LSEIQ2umZpFY
 sFOmP1WadiT5+VYxDC/MkZuYpENZ70uMUoTtSh2Lz0a03vvN4wXLcNljbNgAAJjJRKY=
X-Gm-Gg: AR+sD12pozSN9Icx6ykn6QO7BW/kbmpq2/wCZfA35AAK0wLXF2P8exRWDI+SyH5SLjt
 mcQ44wSDJp5FgI8XrQaUHYxl+U2uYYQJrslp9xmGFwqjBfL4rLCDB2agfD/h/wIWQ4n1DhbTpw0
 lxtdOnU4StDQvEArRiT+jp0PnB7h7wHMXBhwVGxc90SY/odaf0zNXEAjfGB8Bg4151x4xdzFTBY
 FCsQqPeH/Cmc7Cc89kypnymZKB1nAlqT7mej8QcaPpMkZ0sOA4JxHGfswgFTatpalWqeO5hv7QF
 13VyuS8ydxvx21dwP6ghGFnC+liRQgP5OjzYYcdoxZknBNatxd53zbV0Tvv9LyPOxocXI4TU1ak
 6CgIfEjFnsRXwhisnbqgu81a0GoWgt/77/UrtjO3vTTr26G8hm9iwrqbdLBtYob3wU4uzXse+wt
 0F4q/CCkWDzXzw887wKOWOGZWDpZYMgLedHyuPjIQaRcPkQcKcminakvjwJe1fPc6sDGAA+P1RV
 06MKlNf5GnHZM4KwQ5EYbrxMWtNRonWFRgFcubOK91dfg==
X-Received: by 2002:a4a:ec4b:0:b0:69d:e4c8:86f6 with SMTP id
 006d021491bc7-6b1592b8c96mr33422412eaf.15.1787667240188; 
 Tue, 25 Aug 2026 07:14:00 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14186183f31sm31228120c88.13.2026.08.25.07.13.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 07:13:59 -0700 (PDT)
Date: Tue, 25 Aug 2026 07:13:51 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Matthew G. McGovern" <matthew@mcgov.dev>
Cc: Aman Singh <aman.deep.singh@intel.com>, dev@dpdk.org
Subject: Re: [PATCH] testpmd: allow --tx-ip definitions per-port
Message-ID: <20260825071351.4e258b6f@phoenix.local>
In-Reply-To: <20260824231805.256714-1-matthew@mcgov.dev>
References: <20260824231805.256714-1-matthew@mcgov.dev>
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

On Mon, 24 Aug 2026 23:18:21 +0000
"Matthew G. McGovern" <matthew@mcgov.dev> wrote:

> Modifies --tx-ip flag to be of the form:
> 
> --tx-ip=[port_id:]src,dest
> 
> to allow setting the addresses for each port.
> 
> Signed-off-by: Matthew G. McGovern <matthew@mcgov.dev>
> ---

Looks good, applied to next-net
