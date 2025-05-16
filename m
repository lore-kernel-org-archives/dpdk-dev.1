Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09999C3ABD8
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 May 2025 11:08:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C4F5A40144;
	Fri, 16 May 2025 13:08:23 +0200 (CEST)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by mails.dpdk.org (Postfix) with ESMTP id 8E26F400EF
 for <dev@dpdk.org>; Fri, 16 May 2025 13:08:22 +0200 (CEST)
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-7426159273fso2056927b3a.3
 for <dev@dpdk.org>; Fri, 16 May 2025 04:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747393701; x=1747998501; darn=dpdk.org;
 h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=oB4u6zO99tO9sbIMVc3/xIU0/wCUL4szKJBCFnSQwSE=;
 b=JR/RM21Un/F/HbQuFoKkr+LkfyEqbdpeDk20eIKE2rkiE/jh2hc74RLtk25r708yKk
 lv4SdXgIrW8W3+6cyFCfW9SNndFEaab1ExdjzAh0flQckxROaQ/uftmVUkuvVdK5HRMT
 8jaGvBCyhU/7MVrNSPkX4l9c1ETZcVPo5KvJ5ug5l49gKN+UblFMoNO8VKQUvE8Vc1BJ
 +kh0yrnB9VUW2CPMnhKoSN8kj7WOnpiBhmxJiW1FN70cKA3UN/3i7d00LcoDtnzrnTIu
 0/JXbLL73a04ulLwvwsTfAUmdrPfSFoltBNfx0HaOS0ywR+3wnwhrZxEgGQ8L6d7wSby
 UsUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747393701; x=1747998501;
 h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oB4u6zO99tO9sbIMVc3/xIU0/wCUL4szKJBCFnSQwSE=;
 b=pDel/IrElZX/SRZDGfM9Z+NS7Ku/ozyS/edY/a6SrjniWTkb+6atijDcLrratz1dwm
 9KpqxZ8yd8KDDlPfu3ZllhUrC9nspFgL8YSbkchfZGFBIMEBoMxT2nmvhxHOjPEkmHu/
 mJeWtg/keCfl+8aanGF4PG6GTzbCRITaKSp0Lr3V7KwBKxGz81vUatMx/hBZ+EvZB6lv
 MAzMg+8AuXg5hVU8B5AofBSXADCI9/LgAA/+86gOMQbQJTRQCO8ZzzC6iBuqU4vJolV+
 uKmVdJTXGrTGuaUojRyw9+q9r3jjn9pESlme9Zu5Uicv3IqDv9Pr7M79G1OmmUESiQ/a
 KxBA==
X-Gm-Message-State: AOJu0YxhJiYBB4eekSDz9iKUSmuxik4zLw5UZFLOtJFN+Qm3LIlL0lBJ
 +u6+A1h0OXZvAdOq5Gi8eJ9Uj1Mr5FynEUHzJBt3NWtDyOZQVI+IT6Zv
X-Gm-Gg: ASbGnctuzVwAwVRjYf6q4tNcDA/drqyB5RWziH/TdtKodL7JbD3tQPXN1a6nWseAtAA
 ppfEE3ruU8DogH9gvi5bPzsBRkWYlPueDAPR4fZNdDLHd+zFJ43YLcjFv+1qNnGarN6QVnRVsAy
 4ENA1z8tCuLpxY/48xOVtpCeJmXe0ih6WRRWCmjtoIDOxo6mnc2Gq4YEaHfDWgr2XwYVcyvADLn
 ccgGYSkYcpK0C5GY7eeAB4skh9SpAigXW58gjcq13cPIQe+qq0prFK2JPQaQrR0UA1e4OlyDzBM
 2tv9FiLXk6rRFBeG9Z+wN+96T6QD2BtGdACmYtNZ/wXwiyH21y/TCOphYc3MzQqMJQJsM3Khhg=
 =
X-Google-Smtp-Source: AGHT+IEYaqU6NsfzL96s2ZqLo7hz0TBtpKeRe/kfPBE+Ky3BFMI7Qui0I/Ujgl+WXTBf+vhK2oyqXg==
X-Received: by 2002:a05:6a20:c892:b0:215:e53b:9ea6 with SMTP id
 adf61e73a8af0-2170cc56c5fmr3444413637.14.1747393701433; 
 Fri, 16 May 2025 04:08:21 -0700 (PDT)
Received: from [192.168.31.141] ([60.186.106.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a9875e08sm1312300b3a.133.2025.05.16.04.08.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 May 2025 04:08:21 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------Jl0PWgxEpwXxrNAmMJY5mhCG"
Message-ID: <8910af08-3784-4030-bee8-5e0b1031ae78@gmail.com>
Date: Fri, 16 May 2025 19:08:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] eal/linux: skip vfio for non-privileged container
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org
References: <20250117072847.2741-1-ming.1.yang@nokia-sbell.com>
 <20250327075711.648-1-ming.1.yang@nokia-sbell.com>
 <CAJFAV8xGa0y2v_ejaVF8CumzFxK7C5n1=0d4=iQH2ucmLQkiow@mail.gmail.com>
From: Moses Young <mosesyyoung@gmail.com>
In-Reply-To: <CAJFAV8xGa0y2v_ejaVF8CumzFxK7C5n1=0d4=iQH2ucmLQkiow@mail.gmail.com>
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

This is a multi-part message in MIME format.
--------------Jl0PWgxEpwXxrNAmMJY5mhCG
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/16/2025 2:46 PM, David Marchand wrote:
> On Thu, Mar 27, 2025 at 8:57 AM Yang Ming<ming.1.yang@nokia-sbell.com> wrote:
>> DPDK detect vfio container according the existence of vfio
>> module. But for container with non-privileged mode, there is
>> possibility that no VFIO_DIR(/dev/vfio) mapping from host to
>> container when host have both Intel NIC and Mellanox NIC but
>> this conntainer only allocate VFs from Mellanox NIC.
>> In this case, vfio kernel module has already been loaded from
>> the host.
>> This scenario will cause the error log occurs in DPDK primary
>> process as below:
>> 'EAL:   cannot open VFIO container, error 2 (No such file or
>> directory)'
>> 'EAL: VFIO support could not be initialized'
>> Because `rte_vfio_enable()` call `rte_vfio_get_container_fd()`
>> to execute `vfio_container_fd = open(VFIO_CONTAINER_PATH,
>> O_RDWR);` but VFIO_CONTAINER_PATH(/dev/vfio/vfio) doesn't exist
>> in this container.
>> This scenario will also lead to the delay of DPDK secondary
>> process because `default_vfio_cfg->vfio_enabled = 0` and
>> `default_vfio_cfg->vfio_container_fd = -1`, socket error will
>> be set in DPDK primary process when it sync this info to
>> the secondary process.
>> This patch use to skip this kind of useless detection for this
>> scenario.
>>
>> Signed-off-by: Yang Ming<ming.1.yang@nokia-sbell.com>
> With such a change, is the check on the passed kernel module still needed?

Hi David,

Thanks for your comment.

Yes. We still need this checks:
1. Module check (rte_eal_check_module(modname)) ensures the host has the 
VFIO driver loaded.
2. Directory check (opendir("/dev/vfio")) skips the open call in 
unprivileged containers without /dev/vfio, avoiding a noisy error.
This patch adds the second check. Please let me know if you'd like any 
more details!

Best regards,
Yang Ming

--------------Jl0PWgxEpwXxrNAmMJY5mhCG
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 5/16/2025 2:46 PM, David Marchand
      wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAJFAV8xGa0y2v_ejaVF8CumzFxK7C5n1=0d4=iQH2ucmLQkiow@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">On Thu, Mar 27, 2025 at 8:57 AM Yang Ming <a class="moz-txt-link-rfc2396E" href="mailto:ming.1.yang@nokia-sbell.com">&lt;ming.1.yang@nokia-sbell.com&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
DPDK detect vfio container according the existence of vfio
module. But for container with non-privileged mode, there is
possibility that no VFIO_DIR(/dev/vfio) mapping from host to
container when host have both Intel NIC and Mellanox NIC but
this conntainer only allocate VFs from Mellanox NIC.
In this case, vfio kernel module has already been loaded from
the host.
This scenario will cause the error log occurs in DPDK primary
process as below:
'EAL:   cannot open VFIO container, error 2 (No such file or
directory)'
'EAL: VFIO support could not be initialized'
Because `rte_vfio_enable()` call `rte_vfio_get_container_fd()`
to execute `vfio_container_fd = open(VFIO_CONTAINER_PATH,
O_RDWR);` but VFIO_CONTAINER_PATH(/dev/vfio/vfio) doesn't exist
in this container.
This scenario will also lead to the delay of DPDK secondary
process because `default_vfio_cfg-&gt;vfio_enabled = 0` and
`default_vfio_cfg-&gt;vfio_container_fd = -1`, socket error will
be set in DPDK primary process when it sync this info to
the secondary process.
This patch use to skip this kind of useless detection for this
scenario.

Signed-off-by: Yang Ming <a class="moz-txt-link-rfc2396E" href="mailto:ming.1.yang@nokia-sbell.com">&lt;ming.1.yang@nokia-sbell.com&gt;</a>
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
With such a change, is the check on the passed kernel module still needed?
</pre>
    </blockquote>
    <p>Hi David,<br>
      <br>
      Thanks for your comment.</p>
    <p>Yes. We still need this checks:<br>
      1. Module check (rte_eal_check_module(modname)) ensures the host
      has the VFIO driver loaded.<br>
      2. Directory check (opendir("/dev/vfio")) skips the open call in
      unprivileged containers without /dev/vfio, avoiding a noisy error.<br>
      <span class="_fadeIn_m1hgl_8">This </span><span
        class="_fadeIn_m1hgl_8">patch </span><span
        class="_fadeIn_m1hgl_8">adds </span><span
        class="_fadeIn_m1hgl_8">the </span><span
        class="_fadeIn_m1hgl_8">second </span><span
        class="_fadeIn_m1hgl_8">check</span>. <span
        class="_fadeIn_m1hgl_8">Please </span><span
        class="_fadeIn_m1hgl_8">let </span><span
        class="_fadeIn_m1hgl_8">me </span><span class="_fadeIn_m1hgl_8">know
      </span><span class="_fadeIn_m1hgl_8">if </span><span
        class="_fadeIn_m1hgl_8">you'd </span><span
        class="_fadeIn_m1hgl_8">like </span><span
        class="_fadeIn_m1hgl_8">any </span><span
        class="_fadeIn_m1hgl_8">more </span><span
        class="_fadeIn_m1hgl_8">detail</span>s!<br>
      <br>
      Best regards,<br>
      Yang Ming</p>
    <p><span style="white-space: pre-wrap">
</span><span style="white-space: pre-wrap">
</span></p>
  </body>
</html>

--------------Jl0PWgxEpwXxrNAmMJY5mhCG--
