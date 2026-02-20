Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44840C5AD2B
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 17:19:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 87A43402AA;
	Fri, 20 Feb 2026 18:19:52 +0100 (CET)
Received: from mail-qv1-f67.google.com (mail-qv1-f67.google.com
 [209.85.219.67]) by mails.dpdk.org (Postfix) with ESMTP id CD5B74026D
 for <dev@dpdk.org>; Fri, 20 Feb 2026 18:19:50 +0100 (CET)
Received: by mail-qv1-f67.google.com with SMTP id
 6a1803df08f44-89549b2f538so5882396d6.2
 for <dev@dpdk.org>; Fri, 20 Feb 2026 09:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771607990;
 x=1772212790; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c9lFhVbUvWNDGzwOjxCZt+UhKt0bwHaIJa+rtzw6s3M=;
 b=IGHDbWUdb/u6UtpEk3JcFmMlX9U/CNLdVypGBFL0Atls30fPRStptJpBS6ch/PEE71
 p4GcSa4tZWL7bSPlnRtP5h8SLO039wA4Ns96eiPeN4g4JkyVdSgL6S0awNMz1Z0ADsSB
 cn3oq+/MHjDWbSRPuk6OEl+xWqxtiNHBuLoTJ+GBYXSKFsbH9tvaYw56J0/t/CkQzduG
 T4r96/DfCOBHSBNFXQHOB2KfdN/YUeUm7XUve0mM84fbKM2GgIc0zNUNpSz8TRfauEbv
 CbR1uz8TG03EWzse1KjlD/W5bxpYHJk1CWMe7wCD55sy31rzZmIvk6lqdOFRtA3b7NOH
 kaMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771607990; x=1772212790;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=c9lFhVbUvWNDGzwOjxCZt+UhKt0bwHaIJa+rtzw6s3M=;
 b=msdpeCG+mjzBq9xKxUa4lAFaqzA70YnOHoEk2dl11BJQM7/ceSdV56xyayJGgJSU+H
 vzq72NteVdaFd+yQJlPJeVOJt4TJnBRuVBWvBx3gikzAEyg8in+3MiT1k5huKGdWWMug
 Np6UWMN9zF5K+Gi/F4OeLy8x5RR5W52kDmoMo97Osfj0tHlnXK+BLsPnTbItVfCqEShP
 nEh0d/ssUHcZbpDGIRU4otIibJgqDy0pNfdlufLg7br8ryGw37c5b1tB299hRJ9nXyQC
 ArDYTKRes/1JbpkKrGETNUBjhfCEHhZxxihKqpMU/rUjIeJo1w4cHgqlJ+KMjOrhZn60
 TY+w==
X-Gm-Message-State: AOJu0YxBzpUgXt6ezKMvb/8qJ4v5Z7bl66vxEtfDe+Iczcpwp5uMK867
 Mxcmmnc4Q0B6urNm9HWhM5UetMFiYM469jiyEHQ2RC/MwAgHpewtFhkD48XRy4UElzk=
X-Gm-Gg: AZuq6aInwg7ZuWwzXMU68ZwDpz8kWEYkWhvZL0HyTAwTkxOEiXRIoRm1QGrphISIBTz
 FGOvMyq8BmQsVYqFG++4jYBX5YwqJCYoBAM9AqPA1zYS87G3ISQJTkXwyRlGB+yVhVBUiqPcmx3
 LhxrT+bLgKm/1+vjJ1TPJxmZSjyNTaThLjAJIz2y7zjooH0/RXrMiBn1xsU+dnRaMLe60yZ7fOR
 cGUsABqheMK1NQfAfuR7KfWcqWUSa/WvxS7nnR3/Aw1m+wpUDpGLtD65d5XySX/OkpKVFHR0JEv
 5aHLIWNzL6oMyhPOCxw9XDa5TCxtz86cKOeCJg6TefaALioUGJbTbPzKqAnFCdaB3U8zMImvayD
 KyXgHlvgWc7xMMYeiVpdTZqfW2d8jN4jNIqY91hju9QBCGBmqYT/h7jvh+Re8LLfzdoZvDzRxEv
 91vUXR9aZD2oE9957rJxsPf7XGgeg1UqJyQ1y8sL7nQB5pqa6K8Rx1gK16Jo6AnXUj06EymZwpo
 Y8=
X-Received: by 2002:ad4:5cc1:0:b0:894:6d0b:502 with SMTP id
 6a1803df08f44-89979db0e25mr11215616d6.59.1771607990029; 
 Fri, 20 Feb 2026 09:19:50 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8971cd8d33fsm238146396d6.30.2026.02.20.09.19.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Feb 2026 09:19:49 -0800 (PST)
Date: Fri, 20 Feb 2026 09:19:45 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Talluri Chaitanyababu <chaitanyababux.talluri@intel.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com, aman.deep.singh@intel.com
Subject: Re: [PATCH v3] doc: improve e1000 driver documentation
Message-ID: <20260220091945.54af483c@phoenix.local>
In-Reply-To: <20260220211514.2616852-1-chaitanyababux.talluri@intel.com>
References: <20260216195533.2030568-1-chaitanyababux.talluri@intel.com>
 <20260220211514.2616852-1-chaitanyababux.talluri@intel.com>
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

On Fri, 20 Feb 2026 21:15:13 +0000
Talluri Chaitanyababu <chaitanyababux.talluri@intel.com> wrote:

> Update e1000 driver docs to cover all Intel 1G devices,
> including emulated e1000 and real hardware.
>=20
> v3: Resolved apply patch failure.
>=20
> Signed-off-by: Talluri Chaitanyababu <chaitanyababux.talluri@intel.com>

Pointed AI review at this patch, and the overall e1000 driver documentation.

Here's my review of the patch against the existing documentation:

---

**Patch:** `[PATCH v3] doc: improve e1000 driver documentation`
**Author:** Talluri Chaitanyababu <chaitanyababux.talluri@intel.com>

**Summary:** The patch prepends a new top-level section "E1000 Poll Mode Dr=
iver" with an "Overview" subsection to `e1000em.rst`, but there are several=
 issues.

---

**Structural / RST Issues**

The patch inserts a new top-level title ("E1000 Poll Mode Driver", underlin=
ed with `=3D`) before the existing top-level title ("Driver for VM Emulated=
 Devices", also underlined with `=3D`). RST doesn't allow two sections at t=
he same heading level in a document without one being nested under the othe=
r. This creates a document with two competing top-level headings, which is =
likely to confuse Sphinx and render incorrectly. The patch should either re=
place the existing title or restructure so "Driver for VM Emulated Devices"=
 becomes a subsection beneath the new top-level heading.

**Content Accuracy**

The note in the new section states: *"The `igb` and `igc` PMDs are built fr=
om the same driver binary but are documented in separate sections for clari=
ty."* This is misleading. `igb` is a Linux kernel driver, not a DPDK PMD, a=
nd `igc` similarly refers to a kernel driver (for I225/I226). DPDK's 1G PMD=
 for real hardware uses the `e1000` driver. The note should be removed or c=
orrected =E2=80=94 as written it introduces inaccurate information.

**Scope vs. Commit Message**

The commit message says "Update e1000 driver docs to cover all Intel 1G dev=
ices, including emulated e1000 and real hardware," but the patch only adds =
16 lines of overview text and doesn't actually document real hardware (PCI =
IDs, configuration, feature support, etc.). The commit message overclaims w=
hat the patch delivers.

**Content of the Overview**

The bullet point for `e1000e` lists an extensive range of adapters (82563/6=
/7, 82571/2/3/4/7/8/9, 82583, I217/I218/I219) but the existing file is enti=
rely focused on emulated/VM devices. Mixing in details about `e1000e` physi=
cal hardware here, without corresponding documentation for those devices, l=
eaves the overview incomplete and potentially confusing to readers.

**Minor Style Issues**

The note uses a Unicode non-breaking hyphen (`=E2=80=91`) in "PCI=E2=80=91E=
xpress" rather than a regular hyphen or the conventional "PCIe" abbreviatio=
n. This can cause rendering or copy-paste issues and should use standard AS=
CII.

**Existing Document Issues (pre-patch)**

Since you asked for a documentation review of the file as well, a few pre-e=
xisting issues worth noting:

- The document is severely outdated =E2=80=94 it references Fedora 14/18, Q=
EMU 0.14.0/0.15.1, KVM setup instructions from around 2011=E2=80=932012, an=
d kernel version 2.6.25. These sections should either be updated or removed.
- Line 60 has a broken code block: `tar xzf qemu-kvm-release.tar.gz cd qemu=
-kvm-release` =E2=80=94 the `cd` command is on the same line as `tar`, miss=
ing a newline.
- The hyperlinks on lines 53, 81, 95=E2=80=9399 use the old `http://` schem=
e and some point to domains that are likely stale (sourceforge KVM project,=
 `qemu.weilnetz.de`).
- Line 90: "The Qemu" should be "QEMU" (it's an acronym, always uppercase i=
n DPDK docs).
- Lines 113, 114, 120: em-dashes used as list bullets (`=E2=80=94`) are non=
-standard RST; they should use standard `*` bullets or proper RST definitio=
n lists.

---

**Recommendation:** NAK in current form. The structural RST problem (duplic=
ate top-level headings) and the factually inaccurate note about `igb`/`igc`=
 need to be fixed before this can be applied. The commit message also needs=
 to be scoped down to match what the patch actually does.
