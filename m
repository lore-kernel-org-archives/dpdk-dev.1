Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0607EC5AD7B
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Aug 2026 15:28:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C90840272;
	Mon, 10 Aug 2026 17:28:15 +0200 (CEST)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53]) by mails.dpdk.org (Postfix) with ESMTP id 3E16E40144
 for <dev@dpdk.org>; Mon, 10 Aug 2026 17:28:13 +0200 (CEST)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-383cb94f742so2145528a91.3
 for <dev@dpdk.org>; Mon, 10 Aug 2026 08:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786375692;
 x=1786980492; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ah8xKdbaEB1K8M3UylbFd6ROPheYCCnxVMTYSvoDMU0=;
 b=gNuHxZeItDwO+MZj+H9bKZdvRaLMXmIVCI2fsl9PbNxht5SgyKkxLleGgSEAl2nrmx
 MNtn0pJxldyL94BwCqngi+bvOFwHGwd3iCOnQEQX0bpHLGyrhwL9jzqNKOisF4fANaXQ
 jbUyjCklH8zDWqd1g2qwM5qGSIkNIoXGPdonHkbOC+lJ5Na7JydNZ2VRUUMvEa5sQZSs
 Ehw0YoBV8PsDMMXsrZx5OW4zThfzWfx7q2evLGo7cZq1IyExaXFl2KTFFLxaZ7Ts3iEU
 zsyF4lq3e17bw69UiJAAgdD+YADjdASbwp0JHd76c/JtKYTnfTYAPFHsSIHDeh0DQ5H0
 +g2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786375692; x=1786980492;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ah8xKdbaEB1K8M3UylbFd6ROPheYCCnxVMTYSvoDMU0=;
 b=Q0JDqDVA2hT2oOqZ3zPMeNmmsdTUFHdkdTLBovF8T8jKCN0sqW8XwB6mbGlap1hpSV
 DbD7mQsLmUSc9JaFmzep9DfLBzv2UH6dvsXwGto33SQiglKlszucfAhdoUTHGkXsFgT3
 H6Vaw538YtqsCx3j8k+Vbkqz/I67hgr+TBD8RPK8EhFZSGdV98ns28dzS7GxPlFQ7/2b
 9jwKEs32Y5xNR7Adav7wMyTurTcZJhJabGidKzQO7DVxTBztp06i0+yE9AMoLmW8Rlg3
 BnFkR43mn1GqZ+wb/EpFg9v0zDfkcOPjEf+UWDY2rpvQOL8bYcLnRZCZ0EzvArhXMSKh
 HJRw==
X-Gm-Message-State: AOJu0YyapwW371tBKxZoN9w6Zb7P+eo1RrOvEF7LH8xKzj/vvaUNbVys
 h3RG5EV4UHGqODdZPpitvtNwq+3uua2gwRyl6dIWLZNjzBznorN6+GM12qDmYjNuHjg=
X-Gm-Gg: AR+sD13iGN/O2azha3xItBG6xiImTKopAnDxOZQasQZqEjZvRgZVLdXsWEr81sGdG4I
 mB+h4M0csY0xxs6ebcYETu0g4b8Eg5xlbQzsLS8kXAA+RcOou9tKzvzWWRDIzxLXJAXD4WamZhM
 Ri6CQtiNW5CMyODyy7dcHdoF8R7sI1KzOqvi/EGfJNeOBxUroMoRE80hPckSSwfVxMlIkpWuBb7
 +mJ9uV+m9SWzfSLcGEUU4pin4c65T+j4Y0jHVTb6n5MxB2X1hXhzd0E/CWpMHrTqX1AvxY1yA4n
 V73qw2uWgbuBjD8z+f2SUFvSDnjjjGE4SaYcEl8GfC93hBevC4AssFJXX+ka64+STk0TBU0O38w
 El/pi4uWvLvTWVuRqgBUv154bkaneFrN3uAutokSrPc55m7MpJQaLI+kI2iSIJM9QndL3E5cFj8
 VFr8QkifPqIhNmuvLP5sDBZ7tR0KWu2FqZMPf0Iz9ZYEiWYZLFwdFBmtBRlao7KljjVUiuAJEnR
 wQNC2IYF7rOqlE8NshA075lGHcfPQ==
X-Received: by 2002:a17:90b:38d2:b0:38e:11ba:992c with SMTP id
 98e67ed59e1d1-392cca14bf1mr2205725a91.12.1786375691698; 
 Mon, 10 Aug 2026 08:28:11 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14101b7b39bsm35974839c88.14.2026.08.10.08.28.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 08:28:11 -0700 (PDT)
Date: Mon, 10 Aug 2026 08:28:07 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Anurag Mandal <anurag.mandal@intel.com>
Cc: dev@dpdk.org, ciara.loftus@intel.com, mtahhan@redhat.com, stable@dpdk.org
Subject: Re: [PATCH] net/af_xdp: fix default device plugin path
Message-ID: <20260810082807.33fc8a4a@phoenix.local>
In-Reply-To: <20260810101158.1011356-1-anurag.mandal@intel.com>
References: <20260810101158.1011356-1-anurag.mandal@intel.com>
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

On Mon, 10 Aug 2026 10:11:58 +0000
Anurag Mandal <anurag.mandal@intel.com> wrote:

> When use_cni=1 or use_pinned_map=1 is passed without an explicit
> dp_path, the PMD builds the path to the AF_XDP device plugin
> endpoint itself.
> That default was hardcoded to /tmp/afxdp_dp/<if_name>/.
> 
> A unix domain socket and a pinned map are runtime state.
> Current Linux file hierarchy conventions place these below
> the runtime directory, not below world writable /tmp.
> DPDK already exposes such a location through
> rte_eal_get_runtime_dir().
> 
> The location cannot simply be moved as it is a contract
> duplicated in the AF_XDP Device Plugin for Kubernetes,
> which creates the socket and mounts it into the pod at
> the /tmp path the PMD expects.
> Changing only the PMD would break every existing deployment.
> 
> This patch fixes the default so that the endpoint is looked
> up below the EAL runtime directory first, and fall back to
> /tmp/afxdp_dp only when nothing is found there, a warning
> is logged whenever that fallback is taken.
> Existing plugin deployments keep working unchanged, while
> a deployment, that places the endpoint in the runtime
> directory, no longer has to pass dp_path.
> An explicit dp_path still overrides both.
> 
> The <if_name> component is kept in both layouts. It is what
> keeps the endpoints of several interfaces distinct when more
> than one UDS server is mounted in a single pod.
> 
> The runtime directory prefix makes the built path longer,
> so reject a dp_path that does not fit the sun_path field
> of struct sockaddr_un instead of letting strlcpy()
> silently truncate it.
> 
> The interface name check is moved ahead of the path
> construction, as the default path is now built from it.
> 
> Bugzilla ID: 1973
> Fixes: 9c1323736cf9 ("net/af_xdp: fix multi-interface support for k8s")
> Fixes: 8a324b1c6464 ("net/af_xdp: support AF_XDP device plugin pinned maps")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> ---

Don't think changing path should go to stable.

AI review had overly wordy response. But does make good points
that need to be looked at.

Applies cleanly to main (drivers/net/af_xdp/rte_eth_af_xdp.c,
doc/guides/nics/af_xdp.rst, doc/guides/howto/af_xdp_dp.rst).

No correctness bugs found in the C changes. RTE_SIZEOF_FIELD, unistd.h,
sys/un.h and rte_eal.h are all already available in the file; kvlist is
freed unconditionally inside parse_parameters(), so the two new early
returns in probe() do not leak it; snprintf truncation is checked on both
branches; the moved if_name check lands immediately after
parse_parameters(), which is correct.

The findings below are documentation and process.

Warning: doc/guides/howto/af_xdp_dp.rst - stale note contradicts the patch

  The patch rewrites the paragraph at line 70 but leaves the third note
  block untouched. Post-patch the file reads:

     "It looks for afxdp_dp/<if_name>/afxdp.sock ... below the EAL runtime
      directory ... When no such entry exists, the PMD falls back to ..."

  and then, twenty lines later:

     "In these versions of the PMD if a user doesn't explicitly set the
      dp_path parameter when using use_cni then that path is transparently
      configured in the AF_XDP PMD to the default AF_XDP Device Plugin for
      Kubernetes mount point path."

  The second statement is now wrong. Either fold it into the new text or
  reword it to say the legacy mount point is the fallback.

Warning: doc/guides/nics/af_xdp.rst - line exceeds 100 characters

  The new use_pinned_map example is 103 characters:

    --vdev=net_af_xdp0,use_pinned_map=1,dp_path="/var/run/dpdk/rte/afxdp_dp/<<interface name>>/xsks_map"

  The line it replaces was 88. checkpatches.sh will flag this. The use_cni
  example is 98 and is fine.

Warning: doc/guides/nics/af_xdp.rst - /var/run/dpdk/rte is not the runtime
directory in general

  Both examples now hardcode /var/run/dpdk/rte. eal_create_runtime_dir()
  builds <base>/dpdk/<file-prefix>, where <base> is RUNTIME_DIRECTORY if
  set, /var/run for uid 0, and otherwise XDG_RUNTIME_DIR or /tmp. So for a
  non-root run the path is /tmp/dpdk/rte, and any --file-prefix changes the
  last component. A user copying the example verbatim gets a path that does
  not exist, and the "not below world writable /tmp" rationale in the commit
  message does not hold for the non-root case either.

  Suggest keeping <<interface name>> placeholder style for the prefix too,
  e.g. dp_path="<runtime dir>/afxdp_dp/<<interface name>>/afxdp.sock", with
  one sentence saying the runtime directory is what
  rte_eal_get_runtime_dir() returns and depends on uid and --file-prefix.
  That also brings the pinned-map line back under 100 characters.

Warning: doc - "place the pinned map below the EAL runtime directory" is not
actionable as written

  Both new notes say:

     "New deployments should place the socket or pinned map below the EAL
      runtime directory"

  A pinned eBPF map can only be created by bpf_obj_pin() onto a bpffs mount.
  The EAL runtime directory is an ordinary directory created with mkdir(),
  so nothing can be pinned into it directly - it only works if the deployment
  bind-mounts a bpffs entry there, which is what the device plugin does today
  for /tmp/afxdp_dp. Worth saying "mount the endpoint below" rather than
  "place ... below", so readers do not conclude bpf_obj_pin() will work
  against the runtime directory.

Warning: Cc: stable@dpdk.org on a behavior change

  The patch mixes two things. The strlcpy() truncation fix in init_uds_sock()
  and probe(), plus the moved if_name check, are straightforward fixes and
  are good stable material. Preferring the runtime directory over
  /tmp/afxdp_dp is a new default-resolution policy: it introduces a new
  lookup, a new WARNING on every probe of an existing deployment, and a new
  hard -ENAMETOOLONG failure for dp_path values that previously worked
  (truncated). Stable branches are not supposed to take behavior changes.

  Suggest splitting: patch 1 = truncation rejection + if_name reorder, with
  the two Fixes: tags and Cc: stable; patch 2 = runtime directory preference,
  main only, with a release note entry since it changes the documented
  meaning of an existing vdev argument.

Info: get_dflt_dp_path() could apply the sun_path limit so the fallback is
still reachable

  The helper bounds both snprintf() results against PATH_MAX. For the UDS
  case the real limit is sizeof(sun_path) (108), and that limit is only
  applied later in probe(). runtime_dir itself is bounded by UNIX_PATH_MAX,
  so with a long --file-prefix the runtime-directory candidate can exceed
  107 bytes. If that path happens to exist, probe() now fails with
  -ENAMETOOLONG rather than falling back to the legacy path, which would
  have fit. Passing the applicable limit into the helper (or checking
  sun_path on the first candidate before access()) would keep the fallback
  reachable in that case.

Info: the length check in init_uds_sock() is unreachable

  internals->dp_path is only ever populated from the probe()-validated
  dp_path, and probe() already rejects anything >= sizeof(sun_path) when
  use_cni is set. The check inside init_uds_sock() cannot fire. It is
  harmless defense in depth, but if you want only one, init_uds_sock() is
  the better place - it is the actual point of use and covers send_msg(),
  which does the same strlcpy() into dst.sun_path.

Info: WARNING is a strong level for the currently supported configuration

  get_dflt_dp_path() logs at WARNING every time the runtime directory has no
  entry, which is every probe of every existing AF_XDP Device Plugin
  deployment - i.e. the configuration the documentation still describes as
  supported. NOTICE would convey "you may want to migrate" without making
  correctly configured pods look broken in logs.
