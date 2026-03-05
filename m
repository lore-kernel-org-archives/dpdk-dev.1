Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF51F30930
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Mar 2026 10:48:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 15C634068A;
	Thu,  5 Mar 2026 11:48:00 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 5AE844029D
 for <dev@dpdk.org>; Thu,  5 Mar 2026 11:47:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772707678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lm/DpHEwbB/0JvZYq0DGX+w85fWT1AkJpJ0gfY0jQZg=;
 b=Ham2CXmtSF7xDoqR7ZeWtrcFNvHkTb1N4wyUKorbjoESWatwOlRAVL/OUOTw5nUvjUgvxv
 Djlf5I2P19p0rasJW7YYUBoDzYhqeQI7zTkGU6wbV3rU8qC9xeO17c8w+3T3HQ9C6Gjj7u
 mE6ksB2vxk9DywYl/hPozT9h7RJEcTc=
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com
 [74.125.82.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-zaGLUUo4PIW6u6vih3aszg-1; Thu, 05 Mar 2026 05:47:57 -0500
X-MC-Unique: zaGLUUo4PIW6u6vih3aszg-1
X-Mimecast-MFC-AGG-ID: zaGLUUo4PIW6u6vih3aszg_1772707676
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-127337c8e52so40632891c88.1
 for <dev@dpdk.org>; Thu, 05 Mar 2026 02:47:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772707676; x=1773312476;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lm/DpHEwbB/0JvZYq0DGX+w85fWT1AkJpJ0gfY0jQZg=;
 b=sbcBDV5SKXzMIsTE8HdGSYAJnq5NCjSaE0JKJXeQ2Dg9ZM3FD2GyGpMsL6iZ1Rgmzp
 jfu8Sv1EC9NfVNYeCoHVw4vzYTtCIzWdRki/0lH6OcC5KLzoZ3hH1bAdcftD7LY89fQt
 I8iGeYReG1oPZA9Sg2UMiEgsGO2WJTAg1MF8lF4di2VIyWbNTXFH7619nZJ8qkL7T+kS
 60FJsEyUISylhysgTwfpotRoPU1SXI3T3aszQdYKltMq7mGJxJo0D+SiLIfj3AlnRVgc
 Hqr/DnrpdAOYSnCpRUfzS5/zFopiKtwvdQm/m6f9liEfoK85jqzMHcNFVVQo6EMTP7CV
 UsdA==
X-Gm-Message-State: AOJu0YzvHgz0IjHW7cAmbsJMn0FUrm8PnAxrDBIfijNb41UyqmvZoer9
 7xynPzWaeStXS1NaJteJlu8AM+4j+GCrcTMzdF6tx48w+LRmQ1yGRg7I9YZZ7LLZqDqVx1RQzjN
 976JmiCjubeleBYeaY/PjEY82HH8qU5F77dt1jRsCxCnIL2kbtkv+s02uSvM6jNz/5caPDCsUKp
 cQaESNLPvcnRl/XDL588M=
X-Gm-Gg: ATEYQzz0ryo0QJDiv1TcjOmZBpGPP0dvLGgCxMOfzOI3kce3CsT8169Xc2gEbz7shJH
 KZ7DcnkOP7t08FWNojimbPbJXXrw503DSyYM1/1/VSvZsYI9fj7BixG6N4mqsUZhLZzNPXIczqN
 I7bQEGXfSprYz/Nw1Zdl5LIZVtJUrsIeooGEEvwqKWLvFIr/U26YR4flj24CcJmcGq6CPvDYtwd
 MFEgTx7vEVC8Drn/kFnWliUU53C+BC+pjz3NkYqF8J9Sy1lxMXuX/MkvLFePFI5tA==
X-Received: by 2002:a05:7022:221e:b0:124:abaa:7fd5 with SMTP id
 a92af1059eb24-128b70eb47dmr2127456c88.38.1772707676460; 
 Thu, 05 Mar 2026 02:47:56 -0800 (PST)
X-Received: by 2002:a05:7022:221e:b0:124:abaa:7fd5 with SMTP id
 a92af1059eb24-128b70eb47dmr2127443c88.38.1772707675931; Thu, 05 Mar 2026
 02:47:55 -0800 (PST)
MIME-Version: 1.0
References: <20251104080931.8102-1-shperetz@nvidia.com>
 <20260129083435.5054-1-shperetz@nvidia.com>
In-Reply-To: <20260129083435.5054-1-shperetz@nvidia.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Thu, 5 Mar 2026 11:47:43 +0100
X-Gm-Features: AaiRm520TAtbq0JnytO3d1gkThDN4IxO3MkMt4AMk9BxDx7Toxp4u9y004PvWUQ
Message-ID: <CAO55csyz16vSNQdnsqan+q+KHKyrEA_D-6qgdQACQLmDODV5iA@mail.gmail.com>
Subject: Re: [PATCH v3] vhost: fix use-after-free race during cleanup
To: Shani Peretz <shperetz@nvidia.com>
Cc: dev@dpdk.org, stable@dpdk.org, Chenbo Xia <chenbox@nvidia.com>, 
 David Marchand <david.marchand@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5JPydvCYg49rm9FqhjQONg2lVPdovUDY_EexCzkSrWc_1772707676
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Thu, Jan 29, 2026 at 9:35=E2=80=AFAM Shani Peretz <shperetz@nvidia.com> =
wrote:
>
> This commit fixes a use-after-free that causes the application to crash
> on shutdown (detected by ASAN).
>
> The vhost library uses a background event dispatch thread that monitors
> fds with epoll. It runs in an infinite loop, waiting for I/O events
> and calling callbacks when they occur.
>
> During cleanup, a race condition existed:
>
>   Main Thread:                    Event Dispatch Thread:
>   1. Remove fds from fdset        while (1) {
>   2. Close file descriptors           epoll_wait() [gets interrupted]
>   3. rte_eal_cleanup()                [continues loop]
>   4. Unmap hugepages                  Accesses fdset...   CRASH
>                                   }
>
> There was no explicit cleanup of the fdset structure.
> The fdset structure is allocated with rte_zmalloc() and the memory would
> only be reclaimed at application shutdown when rte_eal_cleanup() is calle=
d,
> which invokes rte_eal_memory_detach() to unmap all the hugepage memory.
> Meanwhile, the event dispatch thread could still be running and accessing
> the fdset.
>
> The code had a `destroy` flag that the event dispatch thread checked,
> but it was never set during cleanup, and the code never waited for
> the thread to actually exit before freeing memory.
>
> To fix this, the commit implements fdset_destroy() that sets the destroy
> flag with mutex protection, waits for thread termination, and cleans up
> all resources including the fdset memory.
>
> Update socket.c to call fdset_destroy() when the last vhost-user socket
> is unregistered.
>
> Fixes: 0e38b42bf61c ("vhost: manage FD with epoll")
> Cc: stable@dpdk.org
>
> Signed-off-by: Shani Peretz <shperetz@nvidia.com>
>
> -----------------
> v3:
> removed vduse implementation from this fix
>
> ---
>  lib/vhost/fd_man.c | 45 ++++++++++++++++++++++++++++++++++++++++++++-
>  lib/vhost/fd_man.h |  1 +
>  lib/vhost/socket.c |  7 +++++++
>  3 files changed, 52 insertions(+), 1 deletion(-)
>
Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Thanks,
Maxime

