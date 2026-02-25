Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B79FD3773
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Feb 2026 16:25:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 106B640288;
	Wed, 25 Feb 2026 17:25:31 +0100 (CET)
Received: from mail-qv1-f67.google.com (mail-qv1-f67.google.com
 [209.85.219.67]) by mails.dpdk.org (Postfix) with ESMTP id F29614027F
 for <dev@dpdk.org>; Wed, 25 Feb 2026 17:25:29 +0100 (CET)
Received: by mail-qv1-f67.google.com with SMTP id
 6a1803df08f44-896fd2c5337so58687386d6.2
 for <dev@dpdk.org>; Wed, 25 Feb 2026 08:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772036729;
 x=1772641529; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+BoNR20MCM2b1vrb2ih/9fje5xBC6lnF91WokO+leCg=;
 b=XrOyzr8gZffsYaU5shLlxxRpuLAclhQ4CCoMbxkNs1SnU9f56XU/db8GrYLKPgZrra
 6vKC+xzPEb8EO3pTN4dbM7RKsmVpe/2DI2I8NVl+VSsVyDfzwvgYhc55FEMuhLZ+UYyO
 vD1x8nIvVjFHgXp1W1SFB4SPUXoxSTo4kxc0YwRb3GAEsCOwsO4t/doTaRyURThnnOHg
 qLiNqBrzAyTSwxF0H8mrvLkjKBHk15xyzm/KuY2ijaaFpFNmdMPgyfqD7ZaaBp50v4W1
 3oud7UyWbYzrH1P3Stf2oyjq/kctWn0FbRbQWfFpHRCvdr997RqkLlI+0FrYYeubExwG
 8vYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772036729; x=1772641529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+BoNR20MCM2b1vrb2ih/9fje5xBC6lnF91WokO+leCg=;
 b=muX9KkJurUAtx/bBSTBSZl2ZXEOGIg6H1ZdJaunbOldkTvNUrIAKGiUOzdHW8J2ydq
 1E/diQ60R0ucDREtAXOELd+yo8b/XWy/orDwHF4uc4mDNC+DKplmDXiA7r4C+7X2Lc7P
 BJF8ETCDVCk2JFqUmmQhwj53uGQVEwo0XZDTeO4gVt2nLHYCU5V4vf2QswOzHE3jdeeq
 WpOLuQdW9cXPUK1ZWiF1pc07OkinuzI4LyJxmYo6mqIah9dW9R3vvfUloD999K7bPGRx
 hZbEr+UsI9WVf7J4BCjJarzRMIgwhoRFmg/OTnjwPF1SMxifPiYROKsTFviwR48F2jK3
 s1Rg==
X-Gm-Message-State: AOJu0YzSAi8A7IHLd1ytiL0UUcfsCk3XPGhiCxDQ3dxc9RjWjU1Mw/En
 BljFw81MfGbeduQZbf3clYudf8cbCHRg9YdUV7nr8hjVNen/NufG9T+Edu02JoxzcqE=
X-Gm-Gg: ATEYQzxYjCVWk055v8Y1G/3IyopTpioS0HsJEf/g0ZMZ232OZaJ4vR+uNcb4GdDKy05
 PBNmi07tyBAwJUna5SOcNxxNBqvEKNlEHcGDU2ZxpDtWc2nvq4wxAG7znVh4xxewvFvJKwx/cl+
 6ByUyGdVRweTcDWlPcibF5bZwKawyazGjDWU1XuuuFH+JFatB3ROZLPSEHk0tgRG2zkedIawoYZ
 Hk9fwBF/3qDQncXQy4fIl+hpceCphd7OAuZhj63od1CDdYA5a/aehAmnFNQCIzCOxpbqj601KNZ
 GE1YdDOmItr3P6i4s13/wFRrjLTeSChBpqm2EOhYEubnWtuyrSm2m8eMVkLPR33hB/2Vg1msakC
 B9Fpdd9n6YEBujg3BTeNh2rZHeiHYqS9nROuKjaEUpapOkDSJw912qJvcy/76O/M+VOUtxwy0xX
 SlW621Vj4q78DN7IxiFSmJEvAvlpQFbM8jsDyn6Fn/G33fbvK4tIiFG09nOcKZLore
X-Received: by 2002:a05:6214:410d:b0:899:bbe7:6f80 with SMTP id
 6a1803df08f44-899bbe7731amr26254176d6.42.1772036729113; 
 Wed, 25 Feb 2026 08:25:29 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8997e63091dsm124602386d6.41.2026.02.25.08.25.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 08:25:28 -0800 (PST)
Date: Wed, 25 Feb 2026 08:25:25 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v3 2/2] doc: add device hotplug documentation
Message-ID: <20260225082525.5fc3e0a2@phoenix.local>
In-Reply-To: <5906353fe6b1e388ce9bc44bf600bc94d2006e9d.1772020302.git.anatoly.burakov@intel.com>
References: <7430d193b05505bbb51a508725fd6f671183e132.1772020302.git.anatoly.burakov@intel.com>
 <5906353fe6b1e388ce9bc44bf600bc94d2006e9d.1772020302.git.anatoly.burakov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Wed, 25 Feb 2026 11:52:25 +0000
Anatoly Burakov <anatoly.burakov@intel.com> wrote:

> Currently, device hotplug is not documented except in API headers. Add
> documentation for device hotplug, both for user facing side of it, and a
> high level overview of its internal workings.
>=20
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>=20
> Notes:
>     v2:
>     - Removed "summary" section
>=20
>  doc/guides/prog_guide/dev_args.rst       |   3 +
>  doc/guides/prog_guide/device_hotplug.rst | 286 +++++++++++++++++++++++
>  doc/guides/prog_guide/index.rst          |   1 +
>  3 files changed, 290 insertions(+)
>  create mode 100644 doc/guides/prog_guide/device_hotplug.rst


This is great to see. It would be the flow from kernel to udev/systemd was =
explained.
If I remember right, mlx does this through another IB mechanism.
Also mention this is Linux only.

AI review is good at finding grammar and other things.


---

**Overall assessment:** This is a solid and welcome addition. Device hotplu=
g has long needed proper documentation beyond the API headers. The structur=
e is logical, the code examples are helpful, and the multi-process synchron=
ization section is particularly well done. A few issues worth addressing:

**Technical issues:**

1. **`device_event_callback` return type mismatch (line 289):** The callbac=
k is declared as returning `int`, but `rte_dev_event_cb_fn` is typedef'd as=
 returning `void`. This will cause a compiler warning/error if anyone copie=
s this example verbatim. Should be `void` with no return statement.

2. **Missing error check on `rte_dev_probe()` (line 205):** The "Device Lif=
ecycle Example" calls `rte_dev_probe(devargs)` without checking the return =
value, while the "Basic Usage" example above it correctly shows error handl=
ing. For a reference example demonstrating "proper device lifecycle managem=
ent," this is inconsistent. Should check the return.

3. **`port_id` type (line 203):** `port_id` is declared as `unsigned` but `=
RTE_ETH_FOREACH_MATCHING_DEV` expects `uint16_t`. Should be `uint16_t port_=
id;`.

4. **`rte_eal_hotplug_add()`/`rte_eal_hotplug_remove()` deprecation status =
(line 179):** Are these functions deprecated or planned for deprecation in =
favor of `rte_dev_probe()`/`rte_dev_remove()`? If so, worth mentioning. If =
not, it might still be good to indicate which API is preferred for new code.

**Documentation nits:**

5. **Line 152:** "after the initial EAL initialization has completed" =E2=
=80=94 consider noting that `rte_eal_init()` must have returned successfull=
y, since that's the specific precondition.

6. **Line 224:** "to find newly attached port" =E2=86=92 "to find the newly=
 attached port"

7. **Line 232:** "In addition to providing generic hotplug infrastructure t=
o be used in the above described manner" =E2=80=94 a bit wordy. Consider: "=
In addition to the hotplug APIs described above, EAL also offers a device e=
vent infrastructure."

8. **Line 269:** "When ``RTE_DEV_EVENT_REMOVE`` event is delivered, the EAL=
 has already released all internal resources associated with the device." =
=E2=80=94 Is this accurate? My understanding is that the uevent notificatio=
n tells the application the kernel removed the device, but it's still up to=
 the application to call `rte_dev_remove()` to clean up EAL resources. If t=
he EAL had already cleaned up, there'd be nothing for the application to do=
. Please double-check this claim.

9. **Line 412, nl_groups:** The doc says `nl_groups =3D 0xffffffff`. This i=
s an implementation detail that could change and may be more confusing than=
 helpful for users reading the prog guide. Consider dropping it or noting i=
t's an implementation note.

**Structural:**

10. **Placement in index.rst:** The new page is added right after `dev_args=
` under "Device Libraries," which makes sense given the cross-references. G=
ood.

11. **The "Implementation Details" section** (line 308 onward) switches fro=
m user-facing guidance to internal architecture. This is useful for contrib=
utors but might be better as a separate subsection with a note that it desc=
ribes internals. Currently the document transitions from "here's how to use=
 it" to "here's how it works internally" without much signaling.

**Minor:**
- Copyright says 2025 (line 142) =E2=80=94 should be 2026 given the submiss=
ion date.
